require 'spec_helper'

describe ParticipationsController do
  describe "#create" do
    let(:person) { Factory(:person, :verified_for_webinar => true) }

    context "when a person is already know and verified" do
      it "does not create a participation" do
        lambda{
          post :create, :email => person.email
        }.should_not change{ Participation.count }
      end

      it "sends a confirmation mail" do
        post :create, :email => person.email
        last_email_sent.to.should == [person.email]
      end

      it "shows the user that he should heck his inbox" do
        post :create, :email => person.email
        flash[:notice].should =~ /confirmation.*inbox/i
      end
    end
  end
end