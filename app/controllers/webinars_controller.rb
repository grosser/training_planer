class WebinarsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create]

  def index
    @webinars = Webinar.where('start IS NULL OR start > NOW()').order('start ASC')
  end

  def new
    @webinar = Webinar.new
  end

  def create
    @webinar = Webinar.new(params[:webinar])
    if @webinar.save
      flash[:notice] = :default
      redirect_to @webinar
    else
      flash[:alert] = :default
      render 'new'
    end
  end

  def show
    @webinar = Webinar.find(params[:id])
  end
end