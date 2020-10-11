# Contributing

## Overview

This repo contains:

- `api/`: A Ruby on Rails GraphQL API
- `client/`: A Vue client using the composition API and Vue-Apollo

## Getting Started

> This section will give details related to setting up your development environment for working on the server and client.

### API

To start the server, you will need the following tools installed:

- Ruby 2.7.1, install [here](https://www.ruby-lang.org/en/documentation/installation/)
- Rails 6.0.3.3, install [here](https://rubyonrails.org/)
- PostgreSQL 13.0, install [here](https://www.postgresql.org/download/)

Once those are installed, we'll need to do a few setup tasks. Make sure to run any commands in the `api/` directory.

- Create a copy of the `.env.example` file and name it `.env`:

  ```sh
  cp .env.example .env
  ```

  Open the newly created `.env` file and replace what `DB_USER` is set to with the name of the user that was created when installing PostgreSQL. It typically will either be the same name of your operating system user or `"postgres"`.

- Install the application dependencies:

  ```sh
  bundle install
  ```

- Create the database tables, migrate them, and add the seed data:

  ```sh
  rails db:create db:migrate db:seed
  ```

  _Tip: You can run these separately if you need to: `rails db:seed` or `rails db:migrate`._

  _Tip: If you need to drop the database can you run: `rails db:drop`. Also run `rails help` for a list of all the available commands._

- Finally, we can start the server by running:

  ```sh
  rails s
  ```

  This should output something similar to:

  ```
  => Booting Puma
  => Rails 6.0.3.2 application starting in development
  => Run `rails server --help` for more startup options
  Puma starting in single mode...
  * Version 4.3.5 (ruby 2.7.1-p83), codename: Mysterious Traveller
  * Min threads: 5, max threads: 5
  * Environment: development
  * Listening on tcp://127.0.0.1:3000
  * Listening on tcp://[::1]:3000
  Use Ctrl-C to stop
  ```

  You can now access the API from http://localhost:3000

  - The GraphQL API is located at: [/graphql](http://localhost:3000/graphql)
  - A GUI for the API is located at: [/graphql-playground](http://localhost:3000/graphql-playground)

  _Tip: All changes to the code are hot-reloaded, so you won't need to restart the server every time you make a change._

- And run the tests from the `test/` directory by running:

  ```sh
  rails test
  ```

### Client

To start developing the client, you will need the following tools installed:

- Node 14.12.0, install [here](https://nodejs.org/en/download/)
- Yarn 1.22.10, install [here](https://yarnpkg.com/)

Once you've installed these, run the following commands in the `client/` directory.

- Install the client dependencies:

  ```sh
  yarn
  ```

- Now start the client development server:

  ```sh
  yarn serve
  ```

  That should output something similar to this:

  ```
  DONE  Compiled successfully in 6079ms

  App running at:
  - Local:   http://localhost:8080/
  - Network: http://172.30.125.26:8080/

  Note that the development build is not optimized.
  To create a production build, run yarn build.

  No issues found.
  ```

  You can now view the client by visiting http://localhost:8080/ in your browser.

  From here you can [sign up](http://localhost:8080/signup) a new account or [sign in](http://localhost:8080/signin) to a fake account using the following credentials:

  ```
     Email : test@test.test
  Password : password
  ```
