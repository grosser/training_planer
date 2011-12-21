class TrainingsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update]

  def index
    @trainings = Training.where('start IS NULL OR start > NOW()').order('start ASC')
  end

  def new
    @training = Training.new
  end

  def create
    @training = Training.new(params[:training])
    if @training.save
      flash[:notice] = :default
      redirect_to @training
    else
      flash[:alert] = :default
      render 'new'
    end
  end

  def show
    @training = Training.find(params[:id])
  end

  def edit
    @training = Training.find(params[:id])
  end

  def update
    @training = Training.find(params[:id].to_i)
    if @training.update_attributes(params[:training])
      redirect_to @training, :notice => :default
    else
      flash[:alert] = :default
      render 'edit'
    end
  end
end