require 'test_helper'

include Devise::TestHelpers

class CategoriesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @category = categories(:one)
  end

  test "category should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "category should get new" do
    get :new
    assert_response :success
  end

  test "category should create" do
    assert_difference('Category.count') do
      post :create, category: { name: "#{@category.name}_v2" }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test "category should show" do
    get :show, id: @category
    assert_response :success
  end

  test "category should get edit" do
    get :edit, id: @category
    assert_response :success
  end

  test "category should update" do
    patch :update, id: @category, category: { name: @category.name }
    assert_redirected_to category_path(assigns(:category))
  end

  test "category should destroy" do
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end

    assert_redirected_to categories_path
  end
end
