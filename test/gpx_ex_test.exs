defmodule GpxExTest do
  use ExUnit.Case
  doctest GpxEx

  test "fooling around" do
    {:ok, gpx_doc} = File.read("./test/gpx_files/gdynia-gdansk.gpx")

    gpx_doc
    |> GpxEx.parse_tracks()
    |> IO.inspect()
  end
end
