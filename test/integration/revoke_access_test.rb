require 'test_helper'

class GrantAccessTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @usergroup1 = usergroups(:one)
    @usergroup2 = usergroups(:two)
    @category1 = categories(:one)
    @notice1 = notices(:one)
    @notice2 = notices(:two)
  end

  test "can remove user" do
    post_via_redirect new_user_session_url, 'user[email]' => @user1.email, 'user[password]' => 'password', 'user[remember_me]' => true
    assert_response :ok
    assert_select '#notice', /Signed in successfully/

    delete remove_user_from_group_url(@usergroup1, @user2)
    assert_redirected_to usergroup_path(@usergroup1)
  end

  test "can not remove user if not allowed" do
    post_via_redirect new_user_session_url, 'user[email]' => @user1.email, 'user[password]' => 'password', 'user[remember_me]' => true
    assert_response :ok
    assert_select '#notice', /Signed in successfully/

    delete remove_user_from_group_url(@usergroup2, @user3)
    assert_redirected_to usergroup_path(@usergroup2)
  end

  test "can revoke access" do
    post_via_redirect new_user_session_url, 'user[email]' => @user1.email, 'user[password]' => 'password', 'user[remember_me]' => true
    assert_response :ok
    assert_select '#notice', /Signed in successfully/

    delete revoke_notice_access_url(@notice1, @usergroup1)
    assert_redirected_to notice_path(@notice1)
  end

  test "can not revoke access if not allowed" do
    post_via_redirect new_user_session_url, 'user[email]' => @user1.email, 'user[password]' => 'password', 'user[remember_me]' => true
    assert_response :ok
    assert_select '#notice', /Signed in successfully/

    delete revoke_notice_access_url(@notice2, @usergroup2)
    assert_redirected_to notice_path(@notice2)
  end
end