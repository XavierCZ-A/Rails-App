class ProductsController < ApplicationController
  def index
    # Fetch all products from the database
    @products = Product.all
  end

  def show
    # Fetch a single product from the database, params[:id] is the product id
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(products_params)
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def products_params
    params.require(:product).permit(:title, :description, :price)
  end
end
