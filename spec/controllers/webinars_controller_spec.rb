require 'spec_helper'

describe WebinarsController do
  def self.it_is_protected
    it "is protected" do
      get :new
      response.status.should == 401
    end
  end

  def auth(username=CFG[:basic_auth][:username], password=CFG[:basic_auth][:password])
    @request.env['HTTP_AUTHORIZATION'] = "Basic #{ActiveSupport::Base64.encode64("#{username}:#{password}")}"
  end

  describe "#index" do
    it "renders" do
      get :index
      response.should render_template :index
    end

    it "lists webinars" do
      webinar = Factory(:webinar)
      get :index
      assigns(:webinars).should == [webinar]
    end
  end

  describe "#new" do
    it_is_protected

    it "renders" do
      auth
      get :new
      response.should render_template :new
    end
  end

  describe "#create" do
    it_is_protected

    it "saves" do
      auth
      lambda{
        post :create, :webinar => {:title => 'xxx', :start => '2012-01-01 09:00', :description => 'DDD'}
      }.should change{ Webinar.count }.by +1

      flash[:notice].should_not be_blank
      response.should redirect_to "/webinars/#{Webinar.last.to_param}"
    end

    it "fails to save" do
      auth
      lambda{
        post :create, :webinar => {:title => '', :start => '2012-01-01 09:00', :description => 'DDD'}
      }.should change{ Webinar.count }.by 0

      flash[:alert].should_not be_blank
      response.should render_template 'new'
    end
  end
end