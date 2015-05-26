require 'test_helper'

class GrantAccessTest < ActionDispatch::IntegrationTest
  fixtures :users, :categories

  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @usergroup = usergroups(:one)
    @usergroup2 = usergroups(:two)
    @category = categories(:one)
    @notice = notices(:one)
    @notice2 = notices(:two)
  end

  test 'create notice and grant access to other user' do
    post_via_redirect new_user_session_url, 'user[email]' => @user1.email, 'user[password]' => 'password', 'user[remember_me]' => true
    assert_response :ok
    assert_select '#notice', /Signed in successfully/

    post_via_redirect '/usergroups', usergroup: { name: @usergroup.name }
    assert_response :ok
    assert_select '#notice', /Usergroup was successfully created/

    post_via_redirect add_user_to_group_url(@usergroup.id), user_id: @user2.id
    assert_response :ok
    assert_select '#notice', /User added/

    post_via_redirect '/notices', notice: { title: @notice.title, category_id: @notice.category_id, text: @notice.text }
    assert_response :ok
    assert_select '#notice', /Notice was successfully created/

    post_via_redirect grant_notice_access_url(@notice.id), usergroup_id: @usergroup.id
    assert_response :ok
    assert_select '#notice', /Access granted/

    delete_via_redirect destroy_user_session_url
    assert_response :ok

    post_via_redirect new_user_session_url, 'user[email]' => @user2.email, 'user[password]' => 'password', 'user[remember_me]' => true
    assert_response :ok
    assert_select '#notice', /Signed in successfully/

    get_via_redirect root_url
    assert_response :ok
    assert_select '#granted_notices th'
  end

  test 'do not allow invalid grants' do
    post_via_redirect new_user_session_url, 'user[email]' => @user1.email, 'user[password]' => 'password', 'user[remember_me]' => true
    assert_response :ok
    assert_select '#notice', /Signed in successfully/

    post_via_redirect add_user_to_group_url(@usergroup2.id), user_id: @user3.id
    assert_response :ok
    assert_select '#alert', /You have no right to view this usergroup/

    post_via_redirect grant_notice_access_url(@notice2.id), usergroup_id: @usergroup.id
    assert_response :ok
    assert_select '#alert', /You have no right to grant access/
  end
end