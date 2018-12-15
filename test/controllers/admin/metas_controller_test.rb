require 'test_helper'

class Admin::MetasControllerTest < ActionController::TestCase
  test "should get list_content" do
    get :list_content
    assert_response :success
  end

  test "should get new_content" do
    get :new_content
    assert_response :success
  end

end
