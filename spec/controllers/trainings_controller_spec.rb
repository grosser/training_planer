require 'spec_helper'

describe TrainingsController do
  describe "#index" do
    it "renders" do
      get :index
      response.should render_template :index
    end

    it "lists trainings" do
      training = Factory(:training)
      get :index
      assigns(:trainings).should == [training]
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
        post :create, :training => {:title => 'xxx', :start => '2012-01-01 09:00', :description => 'DDD'}
      }.should change{ Training.count }.by +1

      flash[:notice].should_not be_blank
      response.should redirect_to "/trainings/#{Training.last.to_param}"
    end

    it "fails to save" do
      auth
      lambda{
        post :create, :training => {:title => '', :start => '2012-01-01 09:00', :description => 'DDD'}
      }.should change{ Training.count }.by 0

      flash[:alert].should_not be_blank
      response.should render_template 'new'
    end
  end

  describe "#show" do
    it "renders" do
      get :show, :id => Factory(:training).to_param
      response.should render_template 'show'
    end
  end

  describe "#edit" do
    it_behaves_like "protected", :edit, :id => 1

    it "renders" do
      auth
      get :edit, :id => Factory(:training).to_param
      response.should render_template 'edit'
    end
  end


  describe "#update" do
    it "is protected" do
      put :update, :id => 111
      response.status.should == 401
    end

    it "updates a training" do
      auth
      training = Factory(:training)
      put :update, :id => training.to_param, :training => {:title => 'YYY'}

      training.reload.title.should == 'YYY'
      flash[:notice].should_not be_blank
      response.should redirect_to training_path(training)
    end

    it "does not update a training when params are invalid" do
      auth
      training = Factory(:training)
      put :update, :id => training.to_param, :training => {:title => ''}

      training.reload.title.should be_present
      flash[:alert].should_not be_blank
      response.should render_template 'edit'
    end
  end
end