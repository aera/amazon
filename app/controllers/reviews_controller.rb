class ReviewsController < ApplicationController
  #before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!
  #before_action :authorize_user!, only: [:edit, :destroy, :update]


  def create
    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review.product = @product
    @review.user = current_user

    if @review.save
      redirect_to @product, notice: 'Review Successfully Created!'
    else
      flash[:alert] = 'Review not created'
      render '/products/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])

    if can?(:destroy, @review)
      @review.destroy
      redirect_to product_path(params[:product_id]), notice: 'Review Deleted!'
    else
      head :unauthorized, alert: 'Review NOT Deleted!'
    end
  end

=begin
  def destroy
    @review = Review.find(params[:id])

    if @review.destroy
      redirect_to product_path(params[:product_id]), notice: 'Review Deleted!'
    else
      redirect_to product_path(params[:product_id]), alert: 'Review NOT Deleted!'
    end
  end
=end
  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
