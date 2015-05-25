require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user the name must be uniqe" do
    assert_raise ActiveRecord::RecordInvalid do
      User.create! email: users(:one).email
    end
  end
end
