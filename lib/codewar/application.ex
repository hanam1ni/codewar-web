defmodule Codewar.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = [
      codewar: [
        strategy: Cluster.Strategy.DNSPoll,
        config: [
          polling_interval: 1000,
          query: "codewar-web-staging.codewar-web-staging.local",
          node_basename: "codewar-web-staging"
        ]
      ]
    ]

    children = [
      # Start the Ecto repository
      Codewar.Repo,
      # Start the Telemetry supervisor
      CodewarWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Codewar.PubSub},
      # Start the Endpoint (http/https)
      CodewarWeb.Endpoint,
      {Cluster.Supervisor, [topologies, [name: Codewar.ClusterSupervisor]]}
      # Start a worker by calling: Codewar.Worker.start_link(arg)
      # {Codewar.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Codewar.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CodewarWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
