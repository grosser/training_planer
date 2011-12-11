class WebinarsController < ApplicationController
  def index
    @webinars = Webinar.where('start > NOW()').order('start ASC')
  end
end