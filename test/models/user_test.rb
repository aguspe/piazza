require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "John Doe", email: "johndoe@example.com", password: "password")
  end

  test 'requires name' do
    @user.name = ""
    assert_not @user.valid?
    @user.name = "John Doe"
    assert @user.valid?
  end

  test 'requires email' do
    @user.email = ""
    assert_not @user.valid?
    @user.email = "johndoe@example.com"
    assert @user.valid?
  end

  test 'email is unique' do
    assert @user.valid?
    @user.save
    user2 = @user.dup
    assert_not user2.valid?
  end

  test 'name and email are stripped of extra spaces before saving' do
    @user.name = " John Doe "
    @user.email = " johndoe@example.com "
    @user.save
    assert_equal "John Doe", @user.reload.name
    assert_equal "johndoe@example.com", @user.reload.email
  end

  test 'user requires a password' do
    @user.password = nil
    assert_not @user.valid?
    @user.password = "password"
    assert @user.valid?
  end

  test 'password must be at least 6 characters' do
    @user.password = "pass"
    assert_not @user.valid?
    @user.password = "password"
    assert @user.valid?
  end

  test 'password must be at most 50 characters' do
    @user.password = "a" * 51
    assert_not @user.valid?
    @user.password = "password"
    assert @user.valid?
  end
end
