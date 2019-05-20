defmodule Servy.Conv do
  defstruct method: "", path: "", params: %{}, headers: %{}, resp_body: "", status: nil

  def full_status(conv) do
    "#{conv.status} #{status_reason(conv.status)}"
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      404 => "Not Found",
      500 => "Server Error"
    }[code]
  end
end
