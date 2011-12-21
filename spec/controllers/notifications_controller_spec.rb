require 'spec_helper'


describe NotificationsController do
  let(:person) { Factory(:person) }

  describe "#new" do
    it_behaves_like "protected", :new

    it "renders" do
      auth
      get :new, :notification => {:person_ids => [person.id]}
      response.should render_template :new
      assigns(:notification).person_ids.should == [person.id.to_s]
    end
  end

  describe "#create" do
    it_behaves_like "protected", :create

    context "sending a notification" do
      def make_request(options={})
        auth
        post :create, options.merge(:notification => {:subject => 'xxx', :start => '2012-01-01 09:00', :body => 'DDD', :person_ids => [person.id]})
      end

      it "sends notifications" do
        lambda{ make_request }.should change{ deliveries.size }.by +1
        flash[:notice].should_not be_blank
        response.should redirect_to "/"
      end

      it "redirects to redirect_to" do
        make_request :redirect_to => '/xxx'
        response.should redirect_to "/xxx"
      end
    end

    it "fails to send with invalid params" do
      auth
      lambda{
        post :create, :notification => {}
      }.should_not change{ deliveries.size }

      flash[:alert].should_not be_blank
      response.should render_template 'new'
    end
  end
end
