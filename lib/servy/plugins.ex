defmodule Servy.Plugins do

  alias Servy.Conv
  def rewrite_path(%Conv{path: "/todo"} = conv) do
    %{conv | path: "/todos"}
  end

  def rewrite_path(%Conv{} = conv), do: conv

  def track(%Conv{status: 404, path: path} = conv) do
    IO.puts("Warning: #{path} doesn't exists")
  end

  def track(%Conv{} = conv), do: conv

  def log(%Conv{} = conv), do: IO.inspect(conv)
end
