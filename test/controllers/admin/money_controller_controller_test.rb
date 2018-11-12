require 'test_helper'

class Admin::MoneyControllerControllerTest < ActionController::TestCase
  test "should get money_sent" do
    get :money_sent
    assert_response :success
  end

  test "should get money_request" do
    get :money_request
    assert_response :success
  end

  test "should get manage" do
    get :manage
    assert_response :success
  end

end
