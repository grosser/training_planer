require 'spec_helper'

describe ParticipationsController do
  describe "#create" do
    let(:person) { Factory(:person, :verified_for_webinar => true) }
    let(:webinar) { Factory(:webinar) }

    context "when a person is already know and verified" do
      it "does not create a participation" do
        lambda{
          post :create, :email => person.email, :webinar_id => webinar.id
        }.should_not change{ Participation.count }
      end

      it "does not create a person" do
        person
        lambda{
          post :create, :email => person.email, :webinar_id => webinar.id
        }.should_not change{ Person.count }
      end

      it "sends a confirmation mail" do
        post :create, :email => person.email, :webinar_id => webinar.id
        last_email_sent.to.should == [person.email]
      end

      it "shows the user that he should check his inbox" do
        post :create, :email => person.email, :webinar_id => webinar.id
        flash[:notice].should =~ /confirmation.*inbox/i
      end
    end

    context "when a person is unknown but has a qualified email" do
      it "does not create a participation" do
        lambda{
          post :create, :email => 'new@email.com', :webinar_id => webinar.id
        }.should_not change{ Participation.count }
      end

      it "creates a person" do
        lambda{
          post :create, :email => 'new@email.com', :webinar_id => webinar.id
        }.should change{ Person.count }.by +1
        Person.last.verified_for_webinar.should == true
      end

      it "sends a confirmation mail" do
        post :create, :email => 'new@email.com', :webinar_id => webinar.id
        last_email_sent.to.should == ['new@email.com']
      end

      it "shows the user that he should check his inbox" do
        post :create, :email => 'new@email.com', :webinar_id => webinar.id
        flash[:notice].should =~ /confirmation.*inbox/i
      end
    end
  end

  describe "#confirm" do
    let(:person) { Factory(:person) }
    let(:webinar) { Factory(:webinar) }
    let(:code) { UrlStore.encode("#{person.id}-#{webinar.id}") }

    it "creates my participation" do
      lambda{
        get :confirm, :id => code
      }.should change{ Participation.count }.by +1

      Participation.last.person.should == person
      Participation.last.webinar.should == webinar

      response.should redirect_to "/webinars/#{webinar.to_param}"
      flash[:notice].should_not be_blank
    end

    it "does not create a participation with an invalid code" do
      lambda{
        get :confirm, :id => code+'x'
      }.should_not change{ Participation.count }
      response.body.should include('INVALID URL')
    end
  end
end