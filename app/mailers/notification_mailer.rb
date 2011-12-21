class NotificationMailer < ActionMailer::Base
  def notification(notification, person)
    @notification = notification
    @person = person
    mail(:to => person.email, :subject => notification.subject)
  end
end