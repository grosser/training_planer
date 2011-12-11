class ParticipationMailer < ActionMailer::Base
  layout 'email'
  default :from => "from@example.com"

  def confirm_verified_rsvp(person, webinar)
    @webinar = webinar
    @person = person
    mail(:to => person.email, :subject => "Please confirm your RSVP to #{webinar.title}")
  end

  def admin_confirm_unverified_rsvp(person, webinar)

  end
end
