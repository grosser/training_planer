require 'spec_helper'

describe ParticipationsController do
  describe "#create" do
    let(:webinar) { Factory(:webinar) }
    let(:person) { Factory(:person) }
    let(:email) { person.email }

    def make_request
      post :create, :email => email, :webinar_id => webinar.id, :reason_to_participate => 'xxx'
    end

    context "with known person" do
      context "verified" do
        before do
          person.update_attriutes!(:verified_for_webinar => true)
        end

        it "does not create a participation" do
          lambda{ make_request }.should_not change{ Participation.count }
        end

        it "does not create a person" do
          person
          lambda{ make_request }.should_not change{ Person.count }
          person.reload.reason_to_participate.should == 'xxx'
        end

        it "sends a confirmation mail" do
          make_request
          last_email_sent.to.should == [person.email]
        end

        it "shows the user that he should check his inbox" do
          make_request
          flash[:notice].should =~ /confirmation.*inbox/i
        end
      end

      context "unverified" do
        it "does not create a participation" do
          lambda{ make_request }.should_not change{ Participation.count }
        end

        it "does not create a person" do
          person
          lambda{ make_request }.should_not change{ Person.count }
          person.reload.reason_to_participate.should == 'xxx'
        end

        it "sends a confirmation mail to the admin" do
          make_request
          last_email_sent.to.should == [CFG[:admin_email]]
        end

        it "shows the user that he should wait for the admin" do
          make_request
          flash[:notice].should =~ /wait/i
        end
      end
    end

    context "unknown person" do
      let(:person) { nil }

      context "with qualified email" do
        let(:email) { 'new@email.org' }

        it "does not create a participation" do
          lambda{ make_request }.should_not change{ Participation.count }
        end

        it "creates a verified person" do
          lambda{ make_request }.should change{ Person.count }.by +1
          Person.last.verified_for_webinar.should == true
          Person.last.reason_to_participate.should == 'xxx'
        end

        it "sends a confirmation mail" do
          make_request
          last_email_sent.to.should == ['new@email.org']
        end

        it "shows the user that he should check his inbox" do
          make_request
          flash[:notice].should =~ /confirmation.*inbox/i
        end
      end

      context "with unqualified email" do
        let(:email) { 'new@email.com' }

        it "does not create a participation" do
          lambda{ make_request }.should_not change{ Participation.count }
        end

        it "sends a confirmation mail to the admin" do
          make_request
          last_email_sent.to.should == [CFG[:admin_email]]
        end

        it "creates unverified person" do
          lambda{ make_request }.should change{ Person.count }.by +1
          Person.last.verified_for_webinar.should == false
          Person.last.reason_to_participate.should == 'xxx'
        end

        it "shows the user that he should wait for the admin" do
          make_request
          flash[:notice].should =~ /wait/i
        end
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