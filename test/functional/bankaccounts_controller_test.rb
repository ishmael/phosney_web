require 'test_helper'

class BankaccountsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bankaccounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bankaccount" do
    assert_difference('Bankaccount.count') do
      post :create, :bankaccount => { }
    end

    assert_redirected_to bankaccount_path(assigns(:bankaccount))
  end

  test "should show bankaccount" do
    get :show, :id => bankaccounts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bankaccounts(:one).to_param
    assert_response :success
  end

  test "should update bankaccount" do
    put :update, :id => bankaccounts(:one).to_param, :bankaccount => { }
    assert_redirected_to bankaccount_path(assigns(:bankaccount))
  end

  test "should destroy bankaccount" do
    assert_difference('Bankaccount.count', -1) do
      delete :destroy, :id => bankaccounts(:one).to_param
    end

    assert_redirected_to bankaccounts_path
  end
end
