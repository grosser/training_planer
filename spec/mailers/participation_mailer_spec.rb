require "spec_helper"

describe ParticipationMailer do
  before do
    reset_mailer
  end

  after do
    all_emails.each do |mail|
      mail.body.should_not =~ /="\/"/ # have a path
      mail.body.should_not =~ /&gt;|&lt;/ # have escaped < / >
    end
  end

  it "confirm_rsvp" do
    training = Factory(:training)
    person = Factory(:person)
    ParticipationMailer.confirm_verified_rsvp(person, training).deliver
    last_email_sent.body.should include('RSVP')
    last_email_sent.to.should == [person.email]
  end

  it "admin_confirm_unverified_rsvp" do
    training = Factory(:training)
    person = Factory(:person, :reason_to_participate => "bla\nblub")
    ParticipationMailer.admin_confirm_unverified_rsvp(person, training).deliver
    last_email_sent.body.should include('wants to')
    last_email_sent.to.should == [CFG[:admin_email]]
  end

  it "admin_confirmed_your_rsvp" do
    training = Factory(:training)
    person = Factory(:person)
    ParticipationMailer.admin_confirmed_your_rsvp(person, training).deliver
    last_email_sent.body.should include('RSVP')
    last_email_sent.to.should == [person.email]
  end
end
