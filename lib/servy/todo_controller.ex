defmodule Servy.TodoController do

  alias Servy.Project
  def index(conv) do
    items = todos = Project.list_todos()
    |> Enum.filter(fn(b) -> b.project == "Career" end)
    |> Enum.map(fn(b) -> "<li>#{b.name} - #{b.project}</li>" end)
    |> Enum.join
     %{conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  def show(conv, %{"id" => id}) do
      %{conv | status: 200, resp_body: "ToDo #{id}"}
  end

  def create(conv, params) do
    %{conv | status: 201, resp_body: "Created a ToDo! called #{params["name"]}"}
  end
end
