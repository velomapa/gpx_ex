defmodule GpxEx.Gpx do
  @type t :: %__MODULE__{
          tracks: list(GpxEx.Track.t()),
          waypoints: list(GpxEx.Waypoint.t())
        }

  defstruct tracks: [], waypoints: []
end
