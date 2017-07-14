class ContactController < ApplicationController
  def new
  end

  def create
    @title = params[:title]
    render 'new'
  end
end
