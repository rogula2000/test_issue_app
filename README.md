# Issue Tracker (Rails 7)

A simple issues/projects tracker built with Rails 7.1, Devise authentication, Hotwire (Turbo + Stimulus), Tailwind CSS, and PostgreSQL. It includes Projects, Issues, and Comments with basic CRUD and user authentication.

## Features
- Projects, Issues, Comments
- User authentication with Devise (email/password)
- Hotwire (Turbo + Stimulus) UI
- Tailwind CSS (via tailwindcss CLI v4)
- JS bundling with esbuild
- PostgreSQL database
- RSpec test suite

## Tech Stack
- Ruby 3.3.6, Rails ~> 7.1
- PostgreSQL
- esbuild, Tailwind CSS v4
- Devise, RSpec, FactoryBot, Faker, Shoulda Matchers

## Prerequisites
- Ruby 3.3.6 (recommended via rbenv or asdf)
- Bundler
- Node.js and npm (or Yarn)
- PostgreSQL running locally

## Setup
```bash
# Install Ruby gems
bundle install

# Install JS dependencies
npm install
# or
# yarn install

# Create and migrate the database
bin/rails db:create db:migrate

# (Optional) Seed development data
bin/rails db:seed
```

Database connection (development/test) is configured in `config/database.yml` using URLs:
- development: `postgres://postgres:postgres@localhost:5432/issues_app_development`
- test: `postgres://postgres:postgres@localhost:5432/issues_app_test`

Ensure those databases and credentials exist locally, or adjust `config/database.yml` to match your environment.

## Running the app (recommended)
Use the process manager script to run Rails + asset watchers together:
```bash
bin/dev
```
This starts:
- Web server: `bin/rails server` on port 3000
- JS watcher: `npm run build -- --watch`
- CSS watcher: `npm run build:css -- --watch`

Visit http://localhost:3000

## Building assets manually
```bash
# JavaScript
npm run build

# CSS (Tailwind)
npm run build:css
```
Built assets are output to `app/assets/builds/` (Propshaft serves them).

## Default users (from seeds)
```text
Email: patrykrogula7@gmail.com | Password: test1234
Email: test@test.com          | Password: test123!
```
You can modify `db/seeds.rb` and re-run:
```bash
bin/rails db:seed
```

## Test suite
```bash
# Run all tests
bundle exec rspec

# Example: run a single file
bundle exec rspec spec/models/user_spec.rb
```
Headless system tests use the config in `spec/support/chrome.rb`.

## Useful commands
```bash
# Run database tasks
bin/rails db:create db:migrate db:seed

# Print routes
bin/rails routes | cat

# Open Rails console
bin/rails console
```

## Deployment notes
- The app uses a `Procfile` and `Procfile.dev`. A `postdeploy` command exists for platforms like Render/Heroku to run migrations:
  ```
  postdeploy: bundle exec rake db:migrate
  ```
- For production, set `DATABASE_URL` (see `config/database.yml`).

## Docker (optional)
A `Dockerfile` is included. Example usage:
```bash
docker build -t issue-tracker .
# Ensure your PostgreSQL is reachable and DATABASE_URL is set appropriately
docker run --rm -p 3000:3000 -e DATABASE_URL="postgres://USER:PASS@HOST:5432/DB" issue-tracker
```

## Project structure (high-level)
- `app/models/` — `User`, `Project`, `Issue`, `Comment`
- `app/controllers/` — REST controllers for projects, issues, comments; Devise controllers
- `app/views/` — ERB templates
- `app/javascript/` — Stimulus controllers, Turbo
- `app/assets/stylesheets/application.tailwind.css` — Tailwind entrypoint
- `app/assets/builds/` — Compiled JS/CSS artifacts
- `spec/` — RSpec tests

## License
MIT (or your preferred license)
