require "spec_helper"

describe NotificationMailer do
  before do
    reset_mailer
  end

  after do
    validate_emails_are_sane
  end

  it "notification" do
    person = Factory(:person)
    notification = Notification.new(:subject => 'SUBJECT', :body => 'BODY')
    NotificationMailer.notification(notification, person).deliver
    last_email_sent.body.should include('BODY')
    last_email_sent.to.should == [person.email]
  end
end
