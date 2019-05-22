defmodule Servy.Tracker do

  def get_remote_todo(todo) do
    # CODE GOES HERE TO SEND A REQUEST TO THE EXTERNAL API

    # Sleep to simulate the API delay:
    :timer.sleep(500)

    # Example responses returned from the API:
    servers = %{
      "Home"  => %{ name: "Learn Erlang", important: true},
      "Work"  => %{ name: "Create Tests for API", important: false},
    }

    Map.get(servers, todo)
  end
end
