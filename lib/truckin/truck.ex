defmodule Truckin.Truck do
  @derive {Jason.Encoder, only: [:address, :applicant, :facility_type, :food_items, :point, :distance]}
  use Memento.Table, attributes: [:address, :applicant, :facility_type, :food_items, :point, :distance]
end
