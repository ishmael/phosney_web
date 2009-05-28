require 'test_helper'

class MovementsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movement" do
    assert_difference('Movement.count') do
      post :create, :movement => { }
    end

    assert_redirected_to movement_path(assigns(:movement))
  end

  test "should show movement" do
    get :show, :id => movements(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => movements(:one).to_param
    assert_response :success
  end

  test "should update movement" do
    put :update, :id => movements(:one).to_param, :movement => { }
    assert_redirected_to movement_path(assigns(:movement))
  end

  test "should destroy movement" do
    assert_difference('Movement.count', -1) do
      delete :destroy, :id => movements(:one).to_param
    end

    assert_redirected_to movements_path
  end
end
