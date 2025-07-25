defmodule Ridex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RidexWeb.Telemetry,
      # Start the Ecto repository
      Ridex.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ridex.PubSub},
      # Start Finch
      {Finch, name: Ridex.Finch},
      # Start the Endpoint (http/https)
      RidexWeb.Endpoint
      # Start a worker by calling: Ridex.Worker.start_link(arg)
      # {Ridex.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ridex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RidexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
