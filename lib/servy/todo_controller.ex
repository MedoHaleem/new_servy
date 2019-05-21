defmodule Servy.TodoController do

  alias Servy.Project
  alias Servy.Todo

    @templates_path Path.expand("../../templates", __DIR__)

  def index(conv) do
    items = Project.list_todos()
    |> Enum.filter(&Todo.is_career/1)

     render(conv, "index.eex", todos: items)
  end

  def show(conv, %{"id" => id}) do
    todo = Project.get_todo(id)
    render(conv, "show.eex", todo: todo)
  end

  def create(conv, params) do
    %{conv | status: 201, resp_body: "Created a ToDo! called #{params["name"]}"}
  end

  # defp todo_item(todo) do
  #   "<li>#{todo.name} - #{todo.project}</li>"
  # end


  defp render(conv, template, bindings) do
    content =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)

      %{conv | status: 200, resp_body: content}
  end
end
