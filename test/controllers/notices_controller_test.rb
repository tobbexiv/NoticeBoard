require 'test_helper'

class NoticesControllerTest < ActionController::TestCase
  setup do
    @notice = notices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notice" do
    assert_difference('Notice.count') do
      post :create, notice: { category_id: @notice.category_id, creator_id: @notice.creator_id, text: @notice.text, title: @notice.title }
    end

    assert_redirected_to notice_path(assigns(:notice))
  end

  test "should show notice" do
    get :show, id: @notice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notice
    assert_response :success
  end

  test "should update notice" do
    patch :update, id: @notice, notice: { category_id: @notice.category_id, creator_id: @notice.creator_id, text: @notice.text, title: @notice.title }
    assert_redirected_to notice_path(assigns(:notice))
  end

  test "should destroy notice" do
    assert_difference('Notice.count', -1) do
      delete :destroy, id: @notice
    end

    assert_redirected_to notices_path
  end
end
