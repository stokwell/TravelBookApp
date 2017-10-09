require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:valid)
  end

  test '#trips' do
    assert_equal 2, @user.trips.size
  end

end
