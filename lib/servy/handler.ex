defmodule Servy.Handler do

  alias Servy.Conv
  alias Servy.TodoController

  import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Servy.Parser, only: [parse: 1]
   @pages_path Path.expand("../../pages", __DIR__)
  def handle(request) do
    request |> parse |> rewrite_path |> log |> route |> track |> format_response
  end

  def route(%Conv{method: "GET", path: "/todos"} = conv) do
    TodoController.index(conv)
  end

  def route(%Conv{method: "GET", path: "/todos/" <> id} = conv) do
    params = Map.put(conv.params, "id", id)
    TodoController.show(conv, params)
  end

  def route(%Conv{method: "GET", path: "/projects"} = conv) do
    %{conv | status: 200, resp_body: "Career, Health, Relationships"}
  end


  def route(%Conv{method: "GET", path: "/about"} = conv) do
    file = @pages_path |> Path.join("about.html")
    case File.read(file) do
      {:ok, content} ->
        %{conv | status: 200, resp_body: content}

      {:error, :enoent} ->
        %{conv | status: 404, resp_body: "File not Found"}

      {:error, reason} ->
        %{conv | status: 500, resp_body: "File error: #{reason}"}
    end
  end

  def route(%Conv{method: "POST", path: "/todos"} = conv) do
     TodoController.create(conv, conv.params)
  end

  def route(%Conv{path: path} = conv) do
    %{conv | status: 404, resp_body: "No #{path} here!"}
  end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}\r
    Content-Type: text/html\r
    Content-Length: #{String.length(conv.resp_body)}\r
    \r
    #{conv.resp_body}
    """
  end


end
