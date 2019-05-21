defmodule Servy.Api.TodoController do
  def index(conv) do
    json = Servy.Project.list_todos() |> Poison.encode!

    %{conv | status: 200, resp_content_Type: "application/json",resp_body: json}
  end
end
