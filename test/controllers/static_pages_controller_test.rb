require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get news" do
    get :news
    assert_response :success
  end

  test "should get cv" do
    get :cv
    assert_response :success
  end

  test "should get projects" do
    get :projects
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
