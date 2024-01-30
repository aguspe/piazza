require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'requires name' do
    @user = User.new(name: "", email: "johndoe@example")
    assert_not @user.valid?
    @user.name = "John Doe"
    assert @user.valid?
  end

  test 'requires email' do
    @user = User.new(name: "John Doe", email: "")
    assert_not @user.valid?
    @user.email = "johndoe@example"
    assert @user.valid?
  end

  test 'email is unique' do
    @user = User.new(name: "John Doe", email: "johndoe@example")
    assert @user.valid?
    @user.save
    @user2 = User.new(name: "John Doe", email: "johndoe@example")
    assert_not @user2.valid?
  end

  test 'name and email are stripped of extra spaces before saving' do
    @user = User.new(name: " John Doe ", email: " johndoe@example ")
    assert @user.valid?
    @user.save
    assert_equal @user.name, "John Doe"
    assert_equal @user.email, "johndoe@example"
  end
end
