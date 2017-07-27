class VotesController < ApplicationController
  before_action :find_review, only: [:create]
  before_action :find_vote, only: [:destroy, :update]

  def create
    vote = Vote.new(
      user: current_user,
      review: @review,
      is_up: params[:is_up]
    )

    if vote.save
      # redirect_to product_path(@review.product), notice: 'Thanks for voting!'
      # when providing redirect_to with an instance of a model, rails
      # will attempt to generate the correct for the show action of that model
      # ð is a shortcut for ð
      redirect_to @review.product
    else
      redirect_to @review.product, alert: vote.errors.full_messages.join(', ')
    end
  end

  def destroy
    if @vote.destroy
      redirect_to @vote.review.product
    else
      redirect_to @vote.review.product, alert: vote.errors.full_messages.join(', ')
    end
  end

  def update
    if @vote.update is_up: params[:is_up]
      redirect_to @vote.review.product
    else
      redirect_to @vote.review.product, alert: vote.errors.full_messages.join(', ')
    end
  end

  private
  def find_review
    @review = Review.find(params[:review_id])
  end

  def find_vote
    @vote = Vote.find(params[:id])
  end

end
