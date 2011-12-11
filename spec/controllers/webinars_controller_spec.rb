require 'spec_helper'

describe WebinarsController do
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
end