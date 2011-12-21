class NotificationMailer < ActionMailer::Base
  NOTIFICATION_REPLACEMENTS = [:first_name, :full_name]

  def notification(notification, person)
    @notification = notification
    @person = person
    @replacements = Hash[NOTIFICATION_REPLACEMENTS.map{|f| [f, person.send(f)] }]
    mail(:to => person.email, :subject => notification.subject % @replacements)
  end
end