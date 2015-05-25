require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "category the name must be uniqe" do
    assert_raise ActiveRecord::RecordInvalid do
      Category.create! name: categories(:one).name
    end
  end
end
