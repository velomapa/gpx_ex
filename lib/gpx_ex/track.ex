defmodule GpxEx.Track do
  @type t :: %__MODULE__{segments: list(GpxEx.TrackSegment.t()) | nil, name: String.t() | nil}

  defstruct segments: nil, name: nil
end
