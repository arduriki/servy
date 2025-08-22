defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse
    |> route
    |> format_response
  end

  def parse(request) do
    # Create a map with the method and the path
    [method, path, _] =
      request
      # Split request into a list of lines.
      |> String.split("\n")
      # Get the first line.
      |> List.first()
      # Split the first line to three parts.
      |> String.split(" ")

    # The last expression is the one that is returned from the function
    %{method: method, path: path, resp_body: ""}
  end

  def route(conv) do
    # Update the map (a copy of it rebinded to conv) with a response body.
    %{conv | resp_body: "Bears, Lions, Tigers"}
  end

  def format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

# HTTP request with multiplelines string
request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)
