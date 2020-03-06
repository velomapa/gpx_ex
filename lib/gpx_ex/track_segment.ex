defmodule GpxEx.TrackSegment do
  @type t :: %__MODULE__{points: list(GpxEx.TrackPoint.t)}

  defstruct points: nil
end
