defmodule Truckin.Utilities.Point do
  @derive {Jason.Encoder, only: [:latitude, :longitude]}

  @enforce_keys [:latitude, :longitude]
  defstruct latitude: nil, longitude: nil
  @type t() :: %__MODULE__{
    latitude: float(),
    longitude: float(),
  }
end
