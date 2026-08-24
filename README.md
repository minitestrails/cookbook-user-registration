# Cookbook user registration

Companion Rails app for [How to Test User Registration with Minitest Rails](https://minitestrails.com/blog/testing-user-registration-rails-minitest/).

This cookbook has recipe CRUD, Rails 8 authentication, and email-plus-password sign-up. Guests can browse recipes and register. Any signed-in user can create, edit, or destroy recipes.

Registration is already wired. The model, integration, and system tests in this repo match the post.

This app is tested on Ruby 4.0.6, Rails 8.1.3, Minitest 6.0.6, and selenium-webdriver 4.47.0.

## Follow the post

The system tests use headless Chrome through Selenium. Install Chrome first.

Clone the repo, set up the app, and run the full suite:

```bash
git clone git@github.com:minitestrails/cookbook-user-registration.git
cd cookbook-user-registration
bin/setup --skip-server
bin/rails test:all
```

You should see a green suite. Then open the post and compare it to the tests in this repo.

To run one layer at a time:

```bash
bin/rails test test/models/user_test.rb
bin/rails test test/integration/sign_ups_integration_test.rb
bin/rails test test/system/sign_ups_test.rb
```

Tests load `users(:alice)` from `test/fixtures/users.yml`. That fixture uses `alice@example.com` with password `password`.

## Run the app

If you already ran `bin/setup --skip-server`, start the server with:

```bash
bin/dev
```

To install gems, prepare the database, and start the server in one step, run `bin/setup` with no flags.

Open [http://localhost:3000](http://localhost:3000). Use **Sign up** to create an account. Alice exists only as a test fixture, not in the development database.