# test/system/sign_ups_test.rb
require "application_system_test_case"

class SignUpsTest < ApplicationSystemTestCase
  test "registers a user" do
    visit sign_up_url

    fill_in "Email address", with: "browsercook@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    assert_text "Sign out"
  end
end
