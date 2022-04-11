defmodule GpxEx.Route do
  @type t :: %__MODULE__{points: list(GpxEx.Waypoint.t()), name: String.t() | nil}

  defstruct points: [], name: nil
end
