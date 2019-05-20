defmodule Servy.Todo do
  defstruct id: nil, name: "", project: "", done: false


  def is_career(todo) do
    todo.project == "Career"
  end
end
