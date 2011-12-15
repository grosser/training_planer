class ParticipationMailer < ActionMailer::Base
  layout 'email'
  default :from => "from@example.com"
  helper :application # :all does not work

  def confirm_verified_rsvp(person, training)
    @training = training
    @person = person
    mail(:to => person.email, :subject => "Please confirm your RSVP to #{training.title}")
  end

  def admin_confirm_unverified_rsvp(person, training)
    @training = training
    @person = person
    mail(:to => CFG[:admin_email], :subject => "Please confirm RSVP of #{person.email} for #{training.title}")
  end

  def admin_confirmed_your_rsvp(person, training)
    @training = training
    @person = person
    mail(:to => person.email, :subject => "Your RSVP for #{training.title} is confirmed!")
  end
end
