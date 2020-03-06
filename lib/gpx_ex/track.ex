defmodule GpxEx.Track do
  @type t :: %__MODULE__{segments: list(GpxEx.TrackSegment.t)}

  defstruct segments: nil
end
