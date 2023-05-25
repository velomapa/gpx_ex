defmodule GpxEx.Parser do
  import SweetXml

  def parse(gpx_document) do
    try do
      tracks =
        gpx_document
        |> get_track_elements()
        |> Enum.map(&build_track/1)

      standalone_waypoints =
        gpx_document
        |> get_top_level_waypoint_elements()
        |> Enum.map(&build_waypoint/1)

      routes =
        gpx_document
        |> get_route_elements()
        |> Enum.map(&build_route/1)

      {:ok, %GpxEx.Gpx{tracks: tracks, waypoints: standalone_waypoints, routes: routes}}
    catch
      _kind, {:fatal, {xmerl_error, _, _, _}} -> {:error, xmerl_error}
      _kind, error -> {:error, error}
    end
  end

  defp build_track(track_xml_element) do
    segments =
      track_xml_element
      |> get_segment_elements()
      |> Enum.map(&build_segment/1)

    track_name = optional_string(track_xml_element, "name")

    %GpxEx.Track{segments: segments, name: track_name}
  end

  defp build_segment(segment_xml_element) do
    points =
      segment_xml_element
      |> get_point_elements()
      |> Enum.map(&build_trackpoint/1)

    length = GpxEx.TrackSegment.calc_length(points)
    %GpxEx.TrackSegment{points: points, length: length}
  end

  defp build_trackpoint(point_element) do
    %GpxEx.TrackPoint{
      lat: get_lat(point_element),
      lon: get_lon(point_element),
      ele: get_ele(point_element),
      time: get_time(point_element)
    }
  end

  defp build_route(route_element) do
    %GpxEx.Route{
      name: optional_string(route_element, "name"),
      points:
        route_element
        |> get_route_point_elements()
        |> Enum.map(&build_waypoint/1)
    }
  end

  defp build_waypoint(waypoint_element) do
    %GpxEx.Waypoint{
      lat: get_lat(waypoint_element),
      lon: get_lon(waypoint_element),
      ele: get_ele(waypoint_element),
      name: optional_string(waypoint_element, "name"),
      symbol: optional_string(waypoint_element, "sym"),
      description: optional_string(waypoint_element, "desc"),
      url: optional_string(waypoint_element, "url")
    }
  end

  defp get_track_elements(xml), do: xpath(xml, ~x"//trk"l)
  defp get_segment_elements(xml), do: xpath(xml, ~x"./trkseg"l)
  defp get_point_elements(xml), do: xpath(xml, ~x"./trkpt"l)

  defp get_top_level_waypoint_elements(xml), do: xpath(xml, ~x"//wpt"l)

  defp get_route_elements(xml), do: xpath(xml, ~x"//rte"l)
  defp get_route_point_elements(xml), do: xpath(xml, ~x"./rtept"l)

  defp get_lat(xml), do: xpath(xml, ~x"./@lat"f)
  defp get_lon(xml), do: xpath(xml, ~x"./@lon"f)
  defp get_ele(xml), do: optional_xpath(xml, ~x"./ele/text()"f)
  defp get_time(xml), do: optional_string(xml, "time")

  defp optional_string(xml, element_type) do
    el = xpath(xml, ~x"./#{element_type}")

    if is_nil(el) do
      nil
    else
      xpath(el, ~x"./text()"s)
    end
  end

  defp optional_xpath(xml, path) do
    try do
      xpath(xml, path)
    catch
      _, _ -> nil
    end
  end
end
