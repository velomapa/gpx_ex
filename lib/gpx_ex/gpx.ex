defmodule GpxEx.Gpx do
  @type t :: %__MODULE__{tracks: list(GpxEx.Track.t)}

  defstruct tracks: nil
end
