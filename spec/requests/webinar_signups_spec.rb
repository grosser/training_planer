require 'spec_helper'

describe "Webinar sign up" do
  let(:person) { Factory(:person) }
  let(:webinar) { Factory(:webinar) }

  before do
    person.verified_for_webinar.should == false
    person.email.should =~ /\.com$/
    webinar.participations.count.should == 0
  end

  def rsvp(email)
    visit webinar_path webinar
    fill_in 'email', :with => email
    fill_in 'reason_to_participate', :with => 'Its me, dont you remember!?'
    click_button "RSVP"
  end

  def confirm_via_email(email)
    wait_until{ page.has_content? 'your inbox' }
    open_email email
    lambda{
      visit_in_email 'confirm'
    }.should change{ webinar.participations.count }.by +1
    wait_until{ page.has_content? 'Success' }
  end

  it "allows me to sign up with an verified account" do
    person.update_attributes!(:verified_for_webinar => true)
    rsvp person.email
    confirm_via_email person.email
  end

  it "allows me to sign up with a new account on .org" do
    rsvp 'new@email.org'
    confirm_via_email 'new@email.org'
  end

  it "waits until the admin confirms when I have a .com email" do
    lambda{
      rsvp 'new@email.com'
    }.should change{ Person.count }.by +1

    # admin answers the mail
    wait_until{ page.has_content? 'wait until an admin' }
    open_email CFG[:admin_email]
    lambda{
      visit_in_email 'confirm'
    }.should change{ webinar.participations.count }.by +1

    # person gets a confirmation
    open_email 'new@email.com'
    current_email.body.should include('has been confirmed!')
  end
end
