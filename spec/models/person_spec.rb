require "spec_helper"

describe Person do
  describe "set_verified_for_webinar" do
    it "is set when I have a .org address" do
      person = Factory(:person, :email => 'xxx@xxx.org', :verified_for_webinar => false)
      person.verified_for_webinar.should == true
    end

    it "is set when I have a .gov address" do
      person = Factory(:person, :email => 'xxx@xxx.gov', :verified_for_webinar => false)
      person.verified_for_webinar.should == true
    end

    it "is set when I have a .org address" do
      person = Factory(:person, :email => 'xxx@xxx.com', :verified_for_webinar => false)
      person.verified_for_webinar.should == false
    end

    it "is does not overwrite true" do
      person = Factory(:person, :email => 'xxx@xxx.com', :verified_for_webinar => true)
      person.verified_for_webinar.should == true
    end
  end
end