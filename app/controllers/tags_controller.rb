class TagsController < ApplicationController
  def index
    @tags = Tag.order(name: :asc)
  end

  def show
    @tag = Tag.find(params[:id])
    @products = @tag.products
  end
end
