defmodule GpxEx.TrackPoint do
  @enforce_keys [:lat, :lon]

  # TODO: change type of `time`
  @type t :: %GpxEx.TrackPoint{lat: float(), lon: float(), ele: float() | nil, time: String.t() | nil}

  defstruct lat: nil, lon: nil, ele: nil, time: nil
end
