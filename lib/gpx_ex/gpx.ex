defmodule GpxEx.Gpx do
  @type t :: %__MODULE__{
          tracks: list(GpxEx.Track.t()),
          waypoints: list(GpxEx.Waypoint.t()),
          routes: list(GpxEx.Route.t())
        }

  defstruct tracks: [], waypoints: [], routes: []
end
