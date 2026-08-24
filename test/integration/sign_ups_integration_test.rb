# test/integration/sign_ups_integration_test.rb
require "test_helper"

class SignUpsIntegrationTest < ActionDispatch::IntegrationTest
  test "registers a user" do
    get sign_up_url
    assert_response :success
    assert_select "h1", "Sign Up"
    assert_select "form"

    assert_difference("User.count", 1) do
      post sign_up_url,
           params: {
             user: {
               email_address: "newcook@example.com",
               password: "password",
               password_confirmation: "password"
             }
           }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_match "Sign out", response.body

    user = User.find_by!(email_address: "newcook@example.com")
    assert user.authenticate("password")
  end

  test "rejects invalid registration" do
    assert_no_difference("User.count") do
      post sign_up_url,
           params: {
             user: {
               email_address: "",
               password: "password",
               password_confirmation: "password"
             }
           }
    end

    assert_response :unprocessable_entity
    assert_select "h1", "Sign Up"
    assert_select "form"
    assert_match(/Error:/, response.body)
    assert_match "can't be blank", CGI.unescapeHTML(response.body)
  end

  test "rejects a duplicate email" do
    assert_no_difference("User.count") do
      post sign_up_url,
           params: {
             user: {
               email_address: users(:alice).email_address,
               password: "password",
               password_confirmation: "password"
             }
           }
    end

    assert_response :unprocessable_entity
    assert_select "form"
    assert_match(/Error:/, response.body)
    assert_match(/has already been taken/i, response.body)
  end

  test "signed-in user cannot visit sign-up" do
    sign_in_as users(:alice)

    get sign_up_url
    assert_redirected_to root_path

    assert_no_difference("User.count") do
      post sign_up_url,
           params: {
             user: {
               email_address: "sneaky@example.com",
               password: "password",
               password_confirmation: "password"
             }
           }
    end
    assert_redirected_to root_path
  end
end
