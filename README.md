# GpxEx

Small Elixir library for parsing GPX files. GPX schema definition: https://www.topografix.com/GPX/1/1

## Roadmap

There is no Roadmap yet. Any PR is welcome. The only requirement is that it should follow GPX schema definition.

## Installation

**NOT ON HEX YET.**

Add to deps inside your mix.exs

```elixir
defp deps do
  {:gpx_ex, git: "git@github.com:caspg/gpx_ex.git", tag: "0.3.0"}
end
```

## Usage

```elixir
iex(1)> {:ok, gpx_doc} = File.read("./my_track.gpx")
iex(2)> {:ok, gpx} = GpxEx.parse(gpx_doc)
iex(3)> gpx

%GpxEx.Gpx{
  tracks: [
    %GpxEx.Track{
      name: "Track's name",
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
            }
          ]
        }
      ]
    }
  ]
}
```

## License

The project is available as open source under the terms of the [MIT License](https://github.com/velomapa/gpx_ex/blob/master/LICENSE.md).
