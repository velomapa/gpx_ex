defmodule GpxEx do
  defdelegate parse(gpx_document), to: GpxEx.Parser
end
