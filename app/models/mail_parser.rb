require 'mail'

class MailParser

  def self.perform(raw)
    mail = Mail.new(raw)

    Rails.logger.debug "Host: #{mail.from}"
    Rails.logger.debug "Invitees: #{mail.to}"
    Rails.logger.debug "CC(Account): #{mail.cc}"
    Rails.logger.debug raw

    new_users = []

    unless EmailAddress.where(email: mail.from.first.downcase).exists?
      new_users << User.create(email: mail.from.first.downcase)
    end

    mail.to.each do |email|
      unless EmailAddress.where(email: email.downcase).exists?
        new_users << User.create(email: email.downcase)
      end
    end

    new_users.each { |u| u.reset_authentication_token! }

    create_session(mail, new_users)
  end

  def self.create_session(mail, new_users)
    calendar = scheduled_meeting?(mail)
    create_ad_hoc_session(mail, new_user) unless calendar

    if calendar && !calendar.events.empty?
      Rails.logger.debug "Creating scheduled session"
      start_datetime = calendar.events.first.start_time
      end_datetime = calendar.events.first.finish_time

      host = User.where(email: mail.from.first.downcase).first
      ot_session = OTSDK.create_session("localhost")
      session = Session.create(host_id: host.id, scheduled_session: true, start_datetime: start_datetime, end_datetime: end_datetime, subject: mail.subject, message_body: mail.body, ot_session_id: ot_session.session_id)

      session.invitees << Invitee.new(host: true, user_id: host.id)
      mail.to.each do |email|
        user = EmailAddress.where(email: email.downcase).first.user
        session.users << user
      end

      users = session.users - new_users
      users.each do |user|
        email = RecognizedInvitee.send_invitation(session, user)
        email.deliver
      end
      new_users.each do |user|
        email = UnrecognizedInvitee.send_invitation(session, user)
        email.deliver
      end
    end
  end

  def self.scheduled_meeting?(mail)
    mail.attachments.each do |attm|
      return RiCal.parse_string(attm.decoded).first if attm.filename == "invite.ics" # Google Calendar Invite
    end
    mail.parts.each do |part|
      return RiCal.parse_string(part.body.decoded).first if part.mime_type == "text/calendar" # MS Outlook Invite
    end

    nil
  end

  def self.create_ad_hoc_session(mail, new_users)
    Rails.logger.debug "Creating ad hoc session"
    host = User.where(email: mail.from.first.downcase).first
    ot_session = OTSDK.create_session("localhost")

    session = Session.create(host_id: host.id, scheduled_session: false, start_datetime: Time.now, end_datetime: Time.now + 2.hours, subject: mail.subject, message_body: mail.body, ot_session_id: ot_session.session_id)

    session.invitees << Invitee.new(host: true, user_id: host.id)
    mail.to.each do |email|
      user = EmailAddress.where(email: email.downcase).first.user
      session.users << user
    end

    users = session.users - new_users
    users.each do |user|
      email = RecognizedInvitee.send_invitation(session, user)
      email.deliver
    end
    new_users.each do |user|
      email = UnrecognizedInvitee.send_invitation(session, user)
      email.deliver
    end
  end

end
