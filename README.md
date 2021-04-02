## Introduction

Real-time-based Web application to run competitive programming events at Nimble.

## Project Setup

### Erlang & Elixir

* Erlang 23.2.1 and Elixir 1.11.3

* Recommended version manager.

  - [asdf](https://github.com/asdf-vm/asdf) Erlang & Elixir

### Development

* Install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

* Setup and boot the Docker containers:

  ```sh
  make docker_setup
  ```

* Install Elixir dependencies:

  ```sh
  mix deps.get
  ```

* Install Node dependencies:

  ```sh
  npm install --prefix assets
  ```

* Setup the databases:

  ```sh
  mix ecto.setup
  ```

* Start the Phoenix app

  ```sh
  iex -S mix phx.server
  ```

* Run all tests:

  ```sh
  mix test 
  ```

* Run all lint:

  ```sh
  mix codebase 
  ```

### Production

* Buidl Docker image

  ```sh
  docker-compose build
  ```

## License

This project is Copyright (c) 2014 and onwards. It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
