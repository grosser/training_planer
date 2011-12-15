class TrainingsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create]

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
end