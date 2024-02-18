class ProductsController < ApplicationController
  skip_before_action :pages_protect, only: [:index, :show]

  def index
    @category = Category.all.order(created_at: :desc).load_async

    @pagy, @products = pagy_countless(FindProducts.new.call_params(products_params_index), items: 8)
    # # Fetch all products from the database
    # @products = Product.all.with_attached_image

    # if params[:category_id]
    #   @products = @products.where(category_id: params[:category_id])
    # end

    # if params[:min_price].present?
    #   @products = @products.where("price >= ?", params[:min_price])
    # end

    # if params[:max_price].present?
    #   @products = @products.where("price <= ?", params[:max_price])
    # end

    # if params[:query_text].present?
    #   @products = @products.search_full_text(params[:query_text])
    # end

    # orders = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])

    # # We check if the parameter exists with &
    # @products = @products.order(orders)

  end

  def show
    # Fetch a single product from the database, params[:id] is the product id
    product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Current.user.products.new(products_params)
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

  def products_params_index
    params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page)
  end
end
