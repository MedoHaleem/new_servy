defmodule HandlerTest do
  use ExUnit.Case

  import Servy.Handler, only: [handle: 1]

  test "GET /projects" do
    request = """
    GET /projects HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 29\r
    \r
    Career, Health, Relationships
    """
  end

  test "GET /todos" do
    request = """
    GET /todos HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 152\r
    \r
    <h1>All The Todos!</h1>

    <ul>

        <li>Study Elixir - Career</li>

        <li>Study NodeJs - Career</li>

        <li>Study React - Career</li>

    </ul>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /bigfoot" do
    request = """
    GET /bigfoot HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 404 Not Found\r
    Content-Type: text/html\r
    Content-Length: 17\r
    \r
    No /bigfoot here!
    """
  end

  test "GET /todos/1" do
    request = """
    GET /todos/1 HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 78\r
    \r
    <h1>Show Todo</h1>
    <p>
    Is Study Elixir Is it Done? <strong>true</strong>
    </p>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end


  test "GET /about" do
    request = """
    GET /about HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 140\r
    \r
    <h1>Medo About Page</h1>

    <blockquote>
        Nothing special here to write, I'm just filling the white space to render the page.
    </blockquote>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "POST /todos" do
    request = """
    POST /todos HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    Content-Type: application/x-www-form-urlencoded\r
    Content-Length: 21\r
    \r
    name=workout&project=fitness
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 201 \r
    Content-Type: text/html\r
    Content-Length: 30\r
    \r
    Created a ToDo! called workout
    """
  end



  defp remove_whitespace(text) do
    String.replace(text, ~r{\s}, "")
  end

end
