require 'spec_helper'

describe "Webinar sign up" do
  it "allows me to sign up with an verified account" do
    person = Factory(:person, :verified_for_webinar => true)
    webinar = Factory(:webinar)
    visit webinar_path webinar

    fill_in 'email', :with => person.email
    click_button "RSVP"
    wait_until{ page.has_content? 'your inbox' }

    open_email person.email
    visit_in_email 'confirm'

    wait_until{ page.has_content? 'Success' }
  end
end
