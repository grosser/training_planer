require "spec_helper"

describe Notification do
  describe "#people" do
    it "is empty without person_ids" do
      Notification.new.people.should == []
    end

    it "is all the people in person_ids" do
      person = Factory(:person)
      Notification.new(:person_ids => [person.id, person.id]).people.should == [person]
    end
  end
end
