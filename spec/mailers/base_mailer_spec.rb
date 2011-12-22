require "spec_helper"

class TestBaseMailer < BaseMailer
  def just_send(email)
    mail(:to => email, :subject => "S", :body => "B")
  end
end

describe BaseMailer do
  describe "blacklisting" do
    it "sends to a normal address" do
      person = Factory(:person, :receive_emails => true)
      lambda{
        TestBaseMailer.just_send(person.email).deliver
      }.should change{ deliveries.size }.by +1
    end

    it "does not sends to a blocked address" do
      person = Factory(:person, :receive_emails => false)
      lambda{
        TestBaseMailer.just_send(person.email).deliver
      }.should_not change{ deliveries.size }
    end
  end
end