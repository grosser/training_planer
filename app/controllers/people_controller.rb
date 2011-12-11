class PeopleController < ApplicationController
  before_filter :authenticate

  def index
    @people = Person.order('created_at DESC')
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      flash[:notice] = :default
      redirect_to @person
    else
      flash[:alert] = :default
      render 'new'
    end
  end

  def show
    @person = Person.find(params[:id].to_i)
  end
end