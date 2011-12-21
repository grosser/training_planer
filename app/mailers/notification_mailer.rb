class NotificationMailer < ActionMailer::Base
  def notification(notification, person)
    @notification = notification
    @person = person
    @replacements = Hash[%w[first_name full_name].map{|f| [f, person.send(f)] }]
    mail(:to => person.email, :subject => notification.subject.silent_interpolate(@replacements))
  end
end