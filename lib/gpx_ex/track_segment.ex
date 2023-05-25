defmodule GpxEx.TrackSegment do
  @type t :: %__MODULE__{points: list(GpxEx.TrackPoint.t), length: float()}

  defstruct points: nil, length: nil

  @spec calc_length(list(GpxEx.TrackPoint.t)) :: float()
  def calc_length(points), do: calc_length(0, points)
  def calc_length(length, [_head | _tail = []]), do: length
  def calc_length(length, [ head | tail ]) do
    length = length + calc_length_between_points(head, List.first(tail))
    calc_length(length, tail)
  end

  @spec calc_length_between_points(GpxEx.TrackPoint.t, GpxEx.TrackPoint.t) :: float()
  def calc_length_between_points(start, finish) do
    earth_radius = 6371.0  # Radius of the Earth in kilometers

    d_lat = to_radians(finish.lat - start.lat)
    d_lon = to_radians(finish.lon - start.lon)

    a = haversine(d_lat) + Math.cos(to_radians(start.lat)) * Math.cos(to_radians(finish.lat)) * haversine(d_lon)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    horizontal_length = earth_radius * c
    vertical_length = Kernel.abs(finish.ele/1000 - start.ele/1000)

    length = Math.sqrt(horizontal_length * horizontal_length + vertical_length * vertical_length)
    length*1000
  end

  @spec to_radians(float()) :: float()
  defp to_radians(degrees) do
    degrees * (Math.pi / 180)
  end

  @spec haversine(float()) :: float()
  defp haversine(angle) do
    Math.pow((Math.sin(angle / 2.0)),2)
  end
end
