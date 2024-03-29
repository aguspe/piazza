require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "redirects to feed after successful signup" do
    get sign_up_path
    assert_response :ok

    assert_difference %w[User.count Organization.count], 1 do
      post sign_up_path, params:
        {
          user:
            {
              name: "John",
              email: "johndoe@example.com",
              password: "password",
              password_confirmation: "password"
            }
        }
    end

    assert_redirected_to root_path
    assert_not_empty cookies[:app_session]
    follow_redirect!
    assert_select ".notification.is-success",
                  text: I18n.t("users.create.welcome", name: "John")
  end

  test "renders form with errors when signup fails" do
    get sign_up_path
    assert_response :ok

    assert_no_difference %w[User.count Organization.count] do
      post sign_up_path, params:
        {
          user:
            {
              name: "John",
              email: "johndoe@example.com",
              password: "hello",
              password_confirmation: "hello"
            }
        }
    end

    assert_response :unprocessable_entity
    assert_select "p.is-danger",
                  text: I18n.t("activerecord.errors.models.user.attributes.password.too_short")
  end

  test "renders form with errors when password confirmation does not match" do
    get sign_up_path
    assert_response :ok

    assert_no_difference %w[User.count Organization.count] do
      post sign_up_path, params:
        {
          user:
            {
              name: "John",
              email: "johndoe@example.com",
              password: "password1",
              password_confirmation: "password2"
            }
        }
    end

    assert_response :unprocessable_entity
    assert_select "p.is-danger",
                  text: I18n.t("activerecord.errors.models.user.attributes.password_confirmation.confirmation")
  end
end
