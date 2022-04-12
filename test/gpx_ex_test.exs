defmodule GpxExTest do
  use ExUnit.Case
  doctest GpxEx

  test "parses a track" do
    {:ok, gpx_doc} = File.read("./test/gpx_files/gdynia.gpx")

    expected = %GpxEx.Gpx{
      tracks: [
        %GpxEx.Track{
          name: "Gdynia",
          segments: [
            %GpxEx.TrackSegment{
              points: [
                %GpxEx.TrackPoint{
                  ele: 10.2,
                  lat: 54.519848,
                  lon: 18.539699,
                  time: "2020-02-02T10:37:13Z"
                },
                %GpxEx.TrackPoint{
                  ele: 10.2,
                  lat: 54.519854,
                  lon: 18.53973,
                  time: "2020-02-02T10:37:14Z"
                },
                %GpxEx.TrackPoint{
                  ele: 10.0,
                  lat: 54.519862,
                  lon: 18.539769,
                  time: "2020-02-02T10:37:15Z"
                },
                %GpxEx.TrackPoint{
                  ele: nil,
                  lat: 54.519853,
                  lon: 18.539813,
                  time: nil
                }
              ]
            }
          ]
        }
      ]
    }

    assert {:ok, expected} == GpxEx.parse(gpx_doc)
  end

  test "parses standalone waypoints" do
    {:ok, gpx_doc} = File.read("./test/gpx_files/standalone_wpts.gpx")

    expected = %GpxEx.Gpx{
      waypoints: [
        %GpxEx.Waypoint{
          lat: 39.2,
          lon: -94.5,
          name: "Kansas City, MO",
          symbol: "City",
          description: "Midwestern city",
          url: "https://www.visitkc.com",
          ele: 308.15
        },
        %GpxEx.Waypoint{
          lat: 32.7,
          lon: -117.2,
          name: "San Diego, CA",
          symbol: "City",
          description: "Port city",
          url: "https://www.sandiego.gov/",
          ele: nil
        },
        %GpxEx.Waypoint{
          lat: 36.4,
          lon: -94.2,
          name: "Bentonville, AR",
          symbol: "Town",
          description: nil,
          url: "http://bentonvillear.com/",
          ele: 395
        }
      ]
    }

    assert {:ok, expected} == GpxEx.parse(gpx_doc)
  end

  test "parses routes" do
    {:ok, gpx_doc} = File.read("./test/gpx_files/route.gpx")

    expected = %GpxEx.Gpx{
      routes: [
        %GpxEx.Route{
          name: "Sample route",
          points: [
            %GpxEx.Waypoint{name: "Point 1", lon: -94.5, lat: 39.2, ele: 388.1},
            %GpxEx.Waypoint{name: "Point 2", lon: 120.4, lat: -19.9},
            %GpxEx.Waypoint{name: "Point 3", lon: -0.1, lat: -0.2},
            %GpxEx.Waypoint{name: "Point 4", lon: 0.2, lat: 0.4, ele: -0.1}
          ]
        }
      ]
    }

    assert {:ok, expected} == GpxEx.parse(gpx_doc)
  end
end
