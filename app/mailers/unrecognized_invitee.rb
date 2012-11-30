class UnrecognizedInvitee < ActionMailer::Base
  def send_invitation(session, user)
    @session = session
    @user = user
    params = {
      from: "UC Cloud <app@uccld.com>",
      to: user.email,
      subject: "#{@session.subject} - Video Collaboration Details",
    }

    mail params
  end
end
