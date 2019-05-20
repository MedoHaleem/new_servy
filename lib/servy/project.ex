defmodule Servy.Project do
  alias Servy.Todo

  def list_todos do
    [
      %Todo{id: 1, name: "Study Elixir", project: "Career", done: true},
      %Todo{id: 2, name: "Study NodeJs", project: "Career", done: true},
      %Todo{id: 3, name: "Study React", project: "Career", done: true},
      %Todo{id: 4, name: "Workout", project: "Fintess", done: false},
      %Todo{id: 5, name: "Get high paying job", project: "Finacial", done: false},
      %Todo{id: 6, name: "Get more money", project: "Finacial", done: false}
    ]
  end

  def get_todo(id) when is_integer(id) do
    Enum.find(list_todos(), fn b -> b.id == id end)
  end

  def get_todo(id) when is_binary(id) do
    id |> String.to_integer() |> get_todo()
  end
end
