require 'mail'

class MailParser

  def self.perform(raw)
    mail = Mail.new(raw)
    Rails.logger.debug "Host: #{mail.from}"
    Rails.logger.debug "Invitees: #{mail.to}"
    Rails.logger.debug "CC(Account): #{mail.cc}"
    Rails.logger.debug raw
  end

end
