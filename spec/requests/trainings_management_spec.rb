require 'spec_helper'

describe "Trainings management" do
  it "allows me to create a new training" do
    auth
    visit "/trainings/new"
    fill_in 'training[title]', :with => 'TITLE'
    fill_in 'training[description]', :with => 'DESCR'
    lambda{
      click_button 'Create'
    }.should change{ Training.count }.by(+1)
    page.should have_content('TITLE')
  end

  it "allows me to edit a training" do
    auth
    training = Factory(:training)
    visit edit_training_path training
    fill_in 'training[title]', :with => 'AAAAA'
    click_button 'Save'
    page.should have_content('AAAAA')
    training.reload.title.should == 'AAAAA'
  end
end