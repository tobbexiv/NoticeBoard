require 'test_helper'

include Devise::TestHelpers

class NoticesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @notice = notices(:one)
    @notice2 = notices(:two)
  end

  test "notice should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notices)
  end

  test "notice should get new" do
    get :new
    assert_response :success
  end

  test "notice should create" do
    assert_difference('Notice.count') do
      post :create, notice: { category_id: @notice.category_id, creator_id: @notice.creator_id, text: @notice.text, title: @notice.title }
    end

    assert_redirected_to notice_path(assigns(:notice))
  end

  test "notice should show" do
    get :show, id: @notice
    assert_response :success
  end

  test "notice should get edit" do
    get :edit, id: @notice
    assert_response :success
  end

  test "notice should update notice" do
    patch :update, id: @notice, notice: { category_id: @notice.category_id, creator_id: @notice.creator_id, text: @notice.text, title: @notice.title }
    assert_redirected_to notice_path(assigns(:notice))
  end

  test "notice should destroy" do
    assert_difference('Notice.count', -1) do
      delete :destroy, id: @notice
    end

    assert_redirected_to notices_path
  end

  test "notice can not destroy foreign" do
    assert_no_difference("Notice.count") do
      delete :destroy, id: @notice2
    end

    assert_redirected_to notices_path
  end

  test "notice can not update foreign" do
    get :edit, id: @notice2

    assert_redirected_to notices_path

    patch :update, id: @notice2, notice: { category_id: @notice2.category_id, creator_id: @notice2.creator_id, text: @notice2.text, title: @notice2.title }

    assert_redirected_to notices_path
  end

  test "notice can not view foreign" do
    get :show, id: notices(:three)

    assert_redirected_to notices_path
  end
end
