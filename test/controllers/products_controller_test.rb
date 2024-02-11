require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "render all products" do
    get products_path
    assert_response :success
    assert_select '.product', 2
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
        category_id: categories(:Phone).id
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
