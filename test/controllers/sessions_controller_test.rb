require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
  end

  test 'the user logs in with the right credentials' do
    assert_difference('@user.app_sessions.count', 1) do
      post login_path, params: { user: { email: @user.email, password: 'password' } }

      assert_not_empty cookies[:app_session]
      assert_redirected_to root_path
    end
  end

  test 'the user fails to log in with the wrong credentials' do
    assert_no_difference('@user.app_sessions.count') do
      post login_path, params: { user: { email: @user.email, password: 'wrong_password' } }

      assert_select '.notification', I18n.t('sessions.create.failure')
    end
  end
end
