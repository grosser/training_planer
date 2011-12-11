class ParticipationMailer < ActionMailer::Base
  default :from => "from@example.com"

  def confirm_verified_rsvp(email, webinar)
    @webinar = webinar
    mail(:to => email, :subject => "Please confirm your RSVP to #{webinar.title}")
  end
end
