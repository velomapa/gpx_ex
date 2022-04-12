defmodule GpxEx.Gpx do
  @typedoc """
  A struct representing a fully parsed GPX file.

  GPX files may contain zero or more:

  - Tracks—ordered lists of points describing a path someone traveled.
  - Routes—ordered lists of waypoints representing a series of turn points
    leading to a destination. Whereas a track might sample the GPS location
    of actual movements at some interval, a route represents directions
    such as you might get from a routing application.
  - Waypoints—a point of interest or named feature on a map.
  """
  @type t :: %__MODULE__{
          tracks: list(GpxEx.Track.t()),
          waypoints: list(GpxEx.Waypoint.t()),
          routes: list(GpxEx.Route.t())
        }

  defstruct tracks: [], waypoints: [], routes: []
end
