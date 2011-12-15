require "spec_helper"

describe Person do
  describe "set_verified_for_training" do
    it "is set when I have a .org address" do
      person = Factory(:person, :email => 'xxx@xxx.org', :verified_for_training => false)
      person.verified_for_training.should == true
    end

    it "is set when I have a .gov address" do
      person = Factory(:person, :email => 'xxx@xxx.gov', :verified_for_training => false)
      person.verified_for_training.should == true
    end

    it "is set when I have a .org address" do
      person = Factory(:person, :email => 'xxx@xxx.com', :verified_for_training => false)
      person.verified_for_training.should == false
    end

    it "is does not overwrite true" do
      person = Factory(:person, :email => 'xxx@xxx.com', :verified_for_training => true)
      person.verified_for_training.should == true
    end
  end
end