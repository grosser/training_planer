require "spec_helper"

describe NotificationMailer do
  before do
    reset_mailer
  end

  after do
    validate_emails_are_sane
  end

  describe "#notification" do
    it "sends an email to the receiver" do
      person = Factory(:person)
      notification = Notification.new(:subject => 'SUBJECT', :body => 'BODY')
      NotificationMailer.notification(notification, person).deliver
      last_email_sent.body.should include('BODY')
      last_email_sent.to.should == [person.email]
    end

    it "replaces %{first_name} and %{full_name}" do
      person = Factory(:person)
      notification = Notification.new(:subject => 'SUBJECT %{first_name}', :body => 'BODY %{first_name} %{full_name}')
      NotificationMailer.notification(notification, person).deliver
      last_email_sent.body.should include('BODY John John Doe')
      last_email_sent.subject.should == "SUBJECT John"
    end
  end
end
