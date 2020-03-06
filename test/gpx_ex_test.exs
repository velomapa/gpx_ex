defmodule GpxExTest do
  use ExUnit.Case
  doctest GpxEx

  import SweetXml

  test "fooling around" do
    {:ok, gpx} = File.read("./test/gpx_files/gdynia-gdansk.gpx")

    assert xpath(gpx, ~x"//trk"l) |> length() == 1
    assert xpath(gpx, ~x"//trk[1]/trkseg"l) |> length() == 1
    assert xpath(gpx, ~x"//trk[1]/trkseg[1]/trkpt"l) |> length() == 3994
  end
end
