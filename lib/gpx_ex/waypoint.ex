defmodule GpxEx.Waypoint do
  @moduledoc """
  A single waypoint, which may be part of a route or
  a standalone point-of-interest or named feature.
  """

  @enforce_keys [:lat, :lon]
  defstruct @enforce_keys ++
              [
                ele_m: nil,
                name: nil,
                symbol: nil,
                description: nil,
                url: nil
              ]

  @type t :: %__MODULE__{
          lat: float(),
          lon: float(),
          ele_m: float() | nil,
          name: String.t() | nil,
          symbol: String.t() | nil,
          description: String.t() | nil,
          url: String.t() | nil
        }
end
