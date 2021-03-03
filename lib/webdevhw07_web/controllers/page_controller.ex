defmodule Webdevhw07Web.PageController do
  use Webdevhw07Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
