require 'test_helper'

class RegistsControllerTest < ActionController::TestCase
  setup do
    @regist = regists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regist" do
    assert_difference('Regist.count') do
      post :create, regist: @regist.attributes
    end

    assert_redirected_to regist_path(assigns(:regist))
  end

  test "should show regist" do
    get :show, id: @regist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @regist
    assert_response :success
  end

  test "should update regist" do
    put :update, id: @regist, regist: @regist.attributes
    assert_redirected_to regist_path(assigns(:regist))
  end

  test "should destroy regist" do
    assert_difference('Regist.count', -1) do
      delete :destroy, id: @regist
    end

    assert_redirected_to regists_path
  end
end
