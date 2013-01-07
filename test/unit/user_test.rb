require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_create
    assert_difference "User.count" do
      user = User.create(
        :email                 => 'test@test.com', 
        :password              => 'test',
        :password_confirmation => 'test'
      )
      assert user.unique_token
      assert_equal false, user.verified
    end
  end

  def test_create_invalid
    assert_no_difference "User.count" do
      user = User.create()
      assert user.errors.messages[:email]
      assert user.errors.messages[:password]
    end
  end

  def test_set_password
    user = User.create(
      :email                 => 'test@test.com',
      :password              => 'test',
      :password_confirmation => 'test'
    )
    assert user.password_digest
    assert user.authenticate('test')
  end

end
