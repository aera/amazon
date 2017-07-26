class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_review, only: [:create]
  before_action :find_like, only: [:destroy]

  #def index
  #  @reviews = Review.order(created_at: :desc)
  #end


  def create
    like = Like.new user:current_user, review: @review
    if cannot? :like, @review
      redirect_to @review, alert: 'Cannot like your own review, dummy!'
    elsif like.save
      redirect_to @review.product, notice: 'Thanks for liking!'
    else
      redirect_to @review.product, alert: like.errors.full_messages.join(', ')
    end
  end

  def destroy
    if @like.destroy
      redirect_to @like.review.product, notice: 'sad face'
    else
      redirect_to @like.review.product, alert: @like.errors.full_messages.join(', ')
    end
  end

  private

  def find_review
    @review = Review.find(params[:review_id])
  end

  def find_like
    @like = Like.find(params[:id])
  end

end
