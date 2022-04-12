defmodule GpxEx.Waypoint do
  @enforce_keys [:lat, :lon]
  defstruct @enforce_keys ++
              [
                ele: nil,
                name: nil,
                symbol: nil,
                description: nil,
                url: nil
              ]

  @typedoc """
  A single waypoint, which may be part of a route or
  a standalone point-of-interest or named feature.

  - Lon and lat are in decimal degrees
  - Elevation is in meters (presumably above mean sea level)
  """
  @type t :: %__MODULE__{
          lat: float(),
          lon: float(),
          ele: float() | nil,
          name: String.t() | nil,
          symbol: String.t() | nil,
          description: String.t() | nil,
          url: String.t() | nil
        }
end
