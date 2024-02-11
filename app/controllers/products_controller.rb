class ProductsController < ApplicationController
  def index
    # Fetch all products from the database
    @products = Product.all.with_attached_image.order(created_at: :desc)
  end

  def show
    # Fetch a single product from the database, params[:id] is the product id
    product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(products_params)
    if @product.save
      redirect_to products_path, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    product
  end

  def update
    if product.update(products_params)
      redirect_to products_path, notice: "Product was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if product.destroy
      redirect_to products_path, notice: "Product was successfully destroyed."
    else
      redirect_to products_path, alert: "Error destroying product."
    end
  end

  private

  def products_params
    params.require(:product).permit(:title, :description, :price, :image, :category_id)
  end

  def product
    @product = Product.find(params[:id])
  end
end
