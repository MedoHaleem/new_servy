defmodule Servy.TodoController do

  alias Servy.Project
  alias Servy.Todo
  def index(conv) do
    items = Project.list_todos()
    |> Enum.filter(&Todo.is_career/1)
    |> Enum.map(&todo_item/1)
    |> Enum.join
     %{conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  def show(conv, %{"id" => id}) do
    todo = Project.get_todo(id)
      %{conv | status: 200, resp_body: "ToDo #{todo.id}:#{todo.name}"}
  end

  def create(conv, params) do
    %{conv | status: 201, resp_body: "Created a ToDo! called #{params["name"]}"}
  end

  defp todo_item(todo) do
    "<li>#{todo.name} - #{todo.project}</li>"
  end
end
