class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: [:create]
  before_action :find_favourite, only: [:destroy]

  def create
    favourite = Favourite.new user: current_user, product: @product
    if cannot? :favourite, @product
      redirect_to @product, alert: 'Cannot favourite your own product, dummy!'
    elsif favourite.save
      redirect_to @product, notice: 'Thanks for favouriting!'
    else
      redirect_to @product, alert: favourite.errors.full_messages.join(', ')
    end
  end

  def destroy

    if @favourite.destroy
      puts "finding favourite"
      redirect_to @favourite.product, notice: 'sad face'
    else
      redirect_to @favourite.product, alert: @favourite.errors.full_messages.join(', ')
    end
  end

  private

  def find_product
    #puts "finding product id"
    #puts params
    @product = Product.find(params[:product_id])
  end

  def find_favourite
    # byebug
    @favourite = Favourite.find_by(product_id: params[:id])
  end

end
