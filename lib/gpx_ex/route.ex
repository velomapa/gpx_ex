defmodule GpxEx.Route do
  @typedoc """
  A struct representing a route, an idealized list of turn points that describe
  the directions one should follow to go from one place to another.
  """
  @type t :: %__MODULE__{points: list(GpxEx.Waypoint.t()), name: String.t() | nil}

  defstruct points: [], name: nil
end
