defmodule Truckin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger
  alias Truckin.Truck
  alias Truckin.Utilities.Point

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Truckin.Repo,
      # Start the Telemetry supervisor
      TruckinWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Truckin.PubSub},
      # Start the Endpoint (http/https)
      TruckinWeb.Endpoint
      # Start a worker by calling: Truckin.Worker.start_link(arg)
      # {Truckin.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Truckin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TruckinWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def start_phase(:bootstrap, start_type, phase_args) do
    Logger.debug("Starting phase bootstrap")

    case Memento.Table.create(Truckin.Truck) do
      {:error, error} ->
        Logger.warn("Tried to create mnesia table Truckin.Truck, but got error")
      :ok ->
        Logger.debug("Created mnesia table Truckin.Truck")
    end
  end

  def start_phase(:load_data, start_type, phase_args) do
    Logger.debug("Loading Data")
    Application.app_dir(:truckin, "/priv/Mobile_Food_Facility_Permit.csv")
    |> File.stream!
    |> CSV.decode!(headers: true)
    |> Enum.each(fn x ->
      Memento.transaction! fn ->
        str = %Truck{address: x["Address"], applicant: x["Applicant"], facility_type: x["FacilityType"], food_items: String.split(x["FoodItems"], ": "), point: %Point{latitude: Float.parse(x["Latitude"]) |> elem(0), longitude: Float.parse(x["Longitude"]) |> elem(0)}}
        Memento.Query.write(str)
      end
    end)
    :ok
  end
end
