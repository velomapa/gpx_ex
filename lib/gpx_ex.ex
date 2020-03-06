defmodule GpxEx do
  @moduledoc """
  Documentation for `GpxEx`.
  """

  import SweetXml

  def parse_tracks(gpx_document) do
    tracks =
      gpx_document
      |> get_tracks()
      |> Enum.map(fn track ->
        track
        |> get_segments()
        |> Enum.map(fn segment ->
          segment
          |> get_points()
          |> Enum.map(&build_trackpoint/1)
          |> build_segment()
        end)
        |> Enum.map(&build_track/1)
      end)

    build_gpx(tracks)
  end

  def build_gpx(tracks), do: %GpxEx.Gpx{tracks: tracks}
  def build_track(segments), do: %GpxEx.Track{segments: segments}
  def build_segment(points), do: %GpxEx.TrackSegment{points: points}

  defp build_trackpoint(point_element) do
    %GpxEx.TrackPoint{
      lat: get_lat(point_element),
      lon: get_lon(point_element),
      ele: get_ele(point_element),
      time: get_time(point_element)
    }
  end

  defp get_tracks(gpx_document), do: xpath(gpx_document, ~x"//trk"l)
  defp get_segments(xml_element), do: xpath(xml_element, ~x"./trkseg"l)
  defp get_points(xml_element), do: xpath(xml_element, ~x"./trkpt"l)
  defp get_lat(point_element), do: xpath(point_element, ~x"./@lat"f)
  defp get_lon(point_element), do: xpath(point_element, ~x"./@lon"f)
  defp get_ele(point_element), do: xpath(point_element, ~x"./ele/text()")
  defp get_time(point_element), do: xpath(point_element, ~x"./time/text()")
end
