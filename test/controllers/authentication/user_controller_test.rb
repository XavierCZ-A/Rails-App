require "test_helper"

class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: 'email@hotmail.com', username: 'email1', password: '123456' } }
    end

    assert_redirected_to products_path
  end

end
