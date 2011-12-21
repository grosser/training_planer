require 'spec_helper'

describe "People management" do
  def auth
    page.driver.browser.basic_authorize  CFG[:basic_auth][:username], CFG[:basic_auth][:password]
  end

  it "allows me to create a new person" do
    auth
    visit "/people/new"
    fill_in 'person[email]', :with => 'asdsad@das.com'
    lambda{
      click_button 'Create'
    }.should change{ Person.count }.by(+1)
    page.body.should include('asdsad@das.com')
  end

  it "allows me to edit person" do
    auth
    person = Factory(:person)
    visit person_path person
    fill_in 'person[email]', :with => 'blub@das.com'
    click_button 'Save'
    page.body.should include('blub@das.com')
    person.reload.email.should == 'blub@das.com'
  end
end