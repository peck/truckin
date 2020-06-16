defmodule TruckinWeb.TruckController do
  use TruckinWeb, :controller
  alias Truckin.Truck
  alias Truckin.Utilities.Point
  require Logger

  def index(conn, params = %{}) do
    guards = []
    {:ok, trucks} = Memento.transaction fn -> Memento.Query.select(Truck, guards) end

    trucks =
      trucks
      |> maybe_distance(params)
      |> maybe_sort(params)
      |> maybe_limit(params)
    json(conn, trucks)
  end

  def maybe_distance(trucks, %{"location" => %{"latitude" => latitude, "longitude" => longitude}}) do
    Logger.debug("in distance")
    query_point = %Point{latitude: Float.parse(latitude) |> elem(0), longitude: Float.parse(longitude) |> elem(0)}

    trucks = Enum.map(trucks, fn truck ->
      distance_from_query = Truckin.Utilities.haversine_distance(truck.point, query_point)
      IO.inspect(distance_from_query)
      %{truck | distance: distance_from_query}
    end)
  end

  def maybe_distance(trucks, _) do
    trucks
  end

  def maybe_sort(trucks, %{"sort_by" => "distance"}) do
    Enum.sort(trucks, &(&1.distance <= &2.distance))
  end

  def maybe_sort(trucks, _) do
    trucks
  end

  def maybe_limit(trucks, %{"limit" => limit}) do
    Enum.take(trucks, String.to_integer(limit))
  end

  def maybe_limit(trucks, _) do
    trucks
  end
end
