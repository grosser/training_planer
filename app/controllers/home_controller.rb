class HomeController < ApplicationController
  def ping
    render :text => 'pong'
  end
end
