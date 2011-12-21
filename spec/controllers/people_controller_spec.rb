require 'spec_helper'

describe PeopleController do
  describe "#index" do
    it_behaves_like "protected", :index

    it "renders" do
      auth
      get :index
      response.should render_template :index
    end

    it "lists people" do
      auth
      person = Factory(:person)
      get :index
      assigns(:people).should == [person]
    end
  end

  describe "#new" do
    it_behaves_like "protected", :new

    it "renders" do
      auth
      get :new
      response.should render_template :new
    end
  end

  describe "#create" do
    it_behaves_like "protected", :create

    it "saves" do
      auth
      lambda{
        post :create, :person => {:first_name => 'xxx', :last_name => 'yyy', :email => 'sadads@sadasd.com'}
      }.should change{ Person.count }.by +1

      flash[:notice].should_not be_blank
      response.should redirect_to "/people/#{Person.last.to_param.sub(' ','%20')}"
    end

    it "fails to save with invalid params" do
      auth
      lambda{
        post :create, :person => {:first_name => 'xxx', :last_name => 'yyy', :email => ''}
      }.should change{ Person.count }.by 0

      flash[:alert].should_not be_blank
      response.should render_template 'new'
    end
  end

  describe "#show" do
    it_behaves_like "protected", :show, :id => 1

    it "renders" do
      auth
      get :show, :id => Factory(:person).to_param
      response.should render_template 'show'
    end
  end

  describe "#update" do
    it "is protected" do
      put :update, :id => 111
      response.status.should == 401
    end

    it "updates a person" do
      auth
      person = Factory(:person)
      put :update, :id => person.to_param, :person => {:first_name => 'YYY'}

      person.reload.first_name.should == 'YYY'
      flash[:notice].should_not be_blank
      response.should redirect_to "/people/#{Person.last.to_param.sub(' ','%20')}"
    end

    it "does not update a person when params are invalid" do
      auth
      person = Factory(:person)
      put :update, :id => person.to_param, :person => {:email => ''}

      person.reload.email.should be_present
      flash[:alert].should_not be_blank
      response.should render_template 'show'
    end
  end
end