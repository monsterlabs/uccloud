require 'mail'

class MailParser

  def self.perform(raw)
    mail = Mail.new(raw)
    Rails.logger.debug "Host: #{mail.from}"
    Rails.logger.debug "Invitees: #{mail.to}"
    Rails.logger.debug "CC(Account): #{mail.cc}"
    Rails.logger.debug raw

    mail.to.each do |email|
      unless User.where(email: email).exists?
        User.create(email: email)
      end
    end

    create_session(mail)
  end

  def self.create_session(mail)
    host = User.where(email: mail.from).first
    session = Session.create(host_id: host.id, scheduled_session: false, start_datetime: Time.now, end_datetime: Time.now + 2.hours, subject: mail.subject)
    mail
    session.invitees << Invitee.new(host: true, user_id: host.id)
    mail.to.each do |email|
      user = User.where(email: email).first
      session.users << user
    end
    session.users.each do |user|
      email = UnrecognizedInvitee.send_invitation(session, user)
      email.deliver
    end
  end

end
