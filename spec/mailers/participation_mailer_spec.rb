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
    ParticipationMailer.confirm_verified_rsvp('xxx@yyy.com', webinar).deliver
    last_email_sent.body.should include('RSVP')
    last_email_sent.to.should == ['xxx@yyy.com']
  end
end
