require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  test "should get eyetracking" do
    get :eyetracking
    assert_response :success
  end

end
