class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :destroy, :update]

  def index
     @products = Product.order(created_at: :desc).limit(100)
  end

  def show
    @review = Review.new
    @like = @review.likes.find_by(user: current_user)
    @favourite = @product.favourites.find_by(user: current_user)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      flash[:notice] = "Product created successfully"
      redirect_to product_path(@product)
    else
      flash[:alert] = "Problem creating your product"
      render :new
    end
  end

  def edit
    redirect_to products_path, alert: "Access unauthorized" unless can? :edit, @product   #.edit(product_params)
  end

  def update
    if @product.update(product_params)
      flash[:notice] = 'Product successfully updated.'
      redirect_to product_path(@product)
    else
      flash.now[:alert] = 'Please fix errors'
      render :edit
    end
  end

  def destroy
    if can? :destroy, @product
      @product.destroy
      flash[:notice] = "Product sucessfully deleted."
      redirect_to products_path
    else
      flash[:alert] = "Access Denied. you cannot delete a product that is not yours"
      redirect_to @product
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, :tag_list)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def authorize_user!
    unless can?(:manage, @product)
      head :unauthorized
    end
  end
end
