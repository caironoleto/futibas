# Futibas

Futibas it's the open source fantasy football manager.

## Installing  / Getting started

The following instructions you will install and run the application.

### Prerequisites

To run this application, you will need to install the following dependencies in your system:

* [Elixir](https://elixir-lang.org/install.html)
* [Phoenix](https://hexdocs.pm/phoenix/installation.html)
* [Node](https://nodejs.org)
* [PostgreSQL](https://www.postgresql.org/download/macosx/)

### Installing

To start your Futibas server, first, setup your dev environment

```
cp config/dev.exs.example config/dev.exs
```

Create and migrate your database

```
mix ecto.setup
```

Install Node.js dependencies

```
cd assets && npm install
```

Then:

```
mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Running the tests

Setup you test environment

```
cp config/test.exs.example config/test.exs
```

And run

```
mix test
```

## Deployment

Soon

## Contributing

Soon too

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
