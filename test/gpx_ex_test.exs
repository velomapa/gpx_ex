defmodule GpxExTest do
  use ExUnit.Case
  doctest GpxEx

  test "fooling around" do
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
                  ele: 10.0,
                  lat: 54.519853,
                  lon: 18.539813,
                  time: "2020-02-02T10:37:16Z"
                }
              ]
            }
          ]
        }
      ]
    }

    assert expected == GpxEx.parse(gpx_doc)
  end
end
