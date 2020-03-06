defmodule GpxExTest do
  use ExUnit.Case
  doctest GpxEx

  test "fooling around" do
    {:ok, gpx_doc} = File.read("./test/gpx_files/gdynia.gpx")

    gpx_doc
    |> GpxEx.parse()
    |> IO.inspect()
  end
end
