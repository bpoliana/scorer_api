# ScorerApi

> A Phoenix Api app with a single endpoint. This app returns at maximum 2 (it can return less), users with more than a random number of points.

For running the project locally, follow the instructions on Running section. It is also avaialable in [scorerapi.gigalixirapp.com](https://scorerapi.gigalixirapp.com/) deployed with Gigalixir. 

* This application has a single `GET` endpoint which returns:
  - at max 2 users with a maximum number, which is randomly drawned by a `Genserver`, which is called `ScorerWorker`;
  - timestamp (which indicates the last time someone queried the genserver, defaults to nil for the first query);
* The `User` entity has and `id` and their `points` which are updated by the `ScorerWorker` every minute.
* When you reach the `/` route, it is expected to receive the response:

```
{
  "timestamp":"2022-02-18 02:10:21",
  "users": [
    {"id": 4514, "points": 93},
    {"id": 4606,"points": 93}
  ]
}
```

The application structure relies on a communication in which the `Api` calls the `Genserver` (`ScorerWorker`) that reads and writes in the databases.

## Requirements

For running this application you will need:

* [`elixir 1.13`](https://github.com/asdf-vm/asdf-erlang)
* [`erlang 24.0`](https://github.com/asdf-vm/asdf-elixir)
* [`postgres 14.1`](https://www.postgresql.org/download/)

## Running

Once you have the the Requirenments installed, you can follow the steps:

1. Clone de repository:
```sh
git clone git@github.com:bpoliana/scorer_api.git && cd scorer_api
```
2. Setup your `config/dev.exs` as in the `config/dev.exs.example`:
```
cp config/dev.exs.example config/dev.exs
```

Make sure your local database is configured with your local `Postgres` environments variables, such as in the `config/dev.exs` file, for example:

```elixir
# Configure your database
config :scorer_api, ScorerApi.Repo,
  username: System.get_env("POSTGRES_USER", "postgres"),
  password: System.get_env("POSTGRES_PASSWORD", "postgres"),
  database: "scorer_api_dev",
  hostname: System.get_env("POSTGRES_HOST", "localhost")
```

3. Run the following commands:
```sh
mix deps.get          # gets the project dependencies
mix ecto.setup        # creates the database, runs migrations and also seeds
mix phx.server        # starts the phoenix server
```

Now you can visit [`localhost:4000/`](http://localhost:4000/) from your browser.

## Testing

Setup your `config/test.exs` as in the `config/test.exs.example`:
```
cp config/test.exs.example config/test.exs
```

Make sure you have your tests configs setup properly, including your `Postgres` environment variables. Then just run:

```
mix test
```

### Test coverage

To see the test coverage, it is possible through the Elixir default test coverage:

```
mix test --cover --export-coverage default
mix test.coverage
```

## Improvements

  * Improve tests coverage
  * Automate CI with Gigalixir
  * Fix Gigalixir databases from 10_000 users to have 1_000_000 users
  * Add a code coverage (like codecov, for example)
