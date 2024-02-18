require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
  end

  test "render all products" do
    get products_path
    assert_response :success
    assert_select '.product', 8
    assert_select '.category', 10

  end

  test "render a list of products filter by category" do
    get products_path(category_id: categories(:mobile).id)
    assert_response :success
    assert_select '.product', 3

  end

  test "render a list of products filter by min and max price" do
    get products_path(min_price: 200, max_price: 3000)
    assert_response :success
    assert_select '.product', 8

  end

  test "search a products" do
    get products_path(query_text: 'iphone')
    assert_response :success
    assert_select '.product', 1

  end

  test "sort products by expensive" do
    get products_path(order_by: 'expensive')
    assert_response :success
    assert_select '.product', 8
  end

  test 'render detailed product page' do
    get product_path(products(:laptop))
    assert_response :success
    assert_select '.title', 'Laptop Hp'
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'New Product',
        description: 'New Description',
        price: 100,
        category_id: categories(:mobile).id
        }
      }
    assert_redirected_to products_path
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: 'New Description',
        price: 100
      }
    }
    assert_response :unprocessable_entity
  end

  test 'render edit product form' do
    get edit_product_path(products(:laptop))
    assert_response :success
    assert_select 'form'
  end

  test 'allow to edit a product' do
    patch product_path(products(:laptop)), params: {
      product: {
          price: 100
        }
      }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Product was successfully updated.'
  end

  test 'delete a product' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:laptop))
    end
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Product was successfully destroyed.'
  end

end
