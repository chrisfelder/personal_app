require 'test_helper'

class ExperimentsControllerTest < ActionController::TestCase
  
  def setup
    @board_state = experiments(:one)
    @game2 = experiments(:two)
  end
  
  test "should get forms" do
    get :forms
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end
  

  test "should get reversi" do
    get :reversi
    assert_response :success
  end
  
  test "should create new reversi game" do
    assert_difference('Experiment.count') do
      post(:create, :experiment => {'save_state' => @board_state.save_state })
    end
    
    assert_redirected_to experiment_path(assigns(:experiment))
  end
  
  test "should update reversi game" do
    
    put(:update, id: @game2.id, :experiment => { 'save_state' => @game2.save_state})
    assert_redirected_to experiment_path
  end
  
end
