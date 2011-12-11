class WebinarsController < ApplicationController
  before_filter :authenticate, :only => [:new]

  def index
    @webinars = Webinar.where('start > NOW()').order('start ASC')
  end

  def new
    @webinar = Webinar.new
  end
end