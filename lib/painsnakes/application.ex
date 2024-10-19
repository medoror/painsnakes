defmodule Painsnakes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PainsnakesWeb.Telemetry,
      Painsnakes.Repo,
      {DNSCluster, query: Application.get_env(:painsnakes, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Painsnakes.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Painsnakes.Finch},
      # Start a worker by calling: Painsnakes.Worker.start_link(arg)
      # {Painsnakes.Worker, arg},
      # Start to serve requests, typically the last entry
      PainsnakesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Painsnakes.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PainsnakesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
