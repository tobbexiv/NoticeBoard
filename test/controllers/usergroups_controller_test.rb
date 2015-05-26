require 'test_helper'

include Devise::TestHelpers

class UsergroupsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @usergroup = usergroups(:one)
  end

  test "usergroup should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usergroups)
  end

  test "usergroup should get new" do
    get :new
    assert_response :success
  end

  test "usergroup should create" do
    assert_difference('Usergroup.count') do
      post :create, usergroup: { admin_id: @usergroup.admin_id, name: "#{@usergroup.name}_v2" }
    end

    assert_redirected_to usergroup_path(assigns(:usergroup))
  end

  test "usergroup should show" do
    get :show, id: @usergroup
    assert_response :success
  end

  test "usergroup should get edit" do
    get :edit, id: @usergroup
    assert_response :success
  end

  test "usergroup should update" do
    patch :update, id: @usergroup, usergroup: { admin_id: @usergroup.admin_id, name: @usergroup.name }
    assert_redirected_to usergroup_path(assigns(:usergroup))
  end

  test "usergroup should destroy" do
    assert_difference('Usergroup.count', -1) do
      delete :destroy, id: @usergroup
    end

    assert_redirected_to usergroups_path
  end
end
