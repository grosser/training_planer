require 'spec_helper'

describe "Webinar sign up" do
  it "allows me to sign up with an verified account" do
    person = Factory(:person, :verified_for_webinar => true)
    webinar = Factory(:webinar)
    visit webinar_path webinar

    fill_in 'email', :with => person.email
    click_button "RSVP"
    wait_until{ page.has_content? 'your inbox' }

    last_email_sent
  end
end
