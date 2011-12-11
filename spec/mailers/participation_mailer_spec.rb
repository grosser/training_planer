require "spec_helper"

describe ParticipationMailer do
  before do
    reset_mailer
  end

  after do
    all_emails.each do |mail|
      mail.body.should_not =~ /="\/"/ # have a path
    end
  end

  it "confirm_rsvp" do
    webinar = Factory(:webinar)
    person = Factory(:person)
    ParticipationMailer.confirm_verified_rsvp(person, webinar).deliver
    last_email_sent.body.should include('RSVP')
    last_email_sent.to.should == [person.email]
  end

  it "confirms admin unverified rsvp" do
    webinar = Factory(:webinar)
    person = Factory(:person)
    ParticipationMailer.admin_confirm_unverified_rsvp(person, webinar).deliver
    last_email_sent.body.should include('RSVP')
    last_email_sent.to.should == [CFG[:admin_email]]
  end
end
