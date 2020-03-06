defmodule GpxEx do
  import SweetXml

  def parse(gpx_document) do
    tracks =
      gpx_document
      |> get_track_elements()
      |> Enum.map(&build_track/1)

      %GpxEx.Gpx{tracks: tracks}
  end

  defp build_track(track_xml_element) do
    segments =
      track_xml_element
      |> get_segment_elements()
      |> Enum.map(&build_segment/1)

    %GpxEx.Track{segments: segments}
  end

  defp build_segment(segment_xml_element) do
    points =
      segment_xml_element
      |> get_point_elements()
      |> Enum.map(&build_trackpoint/1)

    %GpxEx.TrackSegment{points: points}
  end

  defp build_trackpoint(point_element) do
    %GpxEx.TrackPoint{
      lat: get_lat(point_element),
      lon: get_lon(point_element),
      ele: get_ele(point_element),
      time: get_time(point_element)
    }
  end

  defp get_track_elements(xml), do: xpath(xml, ~x"//trk"l)
  defp get_segment_elements(xml), do: xpath(xml, ~x"./trkseg"l)
  defp get_point_elements(xml), do: xpath(xml, ~x"./trkpt"l)

  defp get_lat(xml), do: xpath(xml, ~x"./@lat"f)
  defp get_lon(xml), do: xpath(xml, ~x"./@lon"f)
  defp get_ele(xml), do: xpath(xml, ~x"./ele/text()")
  defp get_time(xml), do: xpath(xml, ~x"./time/text()")
end
