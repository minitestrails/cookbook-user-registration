# Cookbook app (registration blog companion)

Cookbook app for the Minitest Rails registration post. Recipe CRUD, Rails 8 authentication, and email-plus-password sign-up. Guests can browse recipes and register. Any signed-in user can create, edit, or destroy recipes. No recipe ownership and no nested ingredients or steps.

Ruby 4.0.5, Rails 8.1.

Sign in as `alice@example.com` with password `password`.

```
bin/setup
bin/rails test
bin/rails test:system
```
