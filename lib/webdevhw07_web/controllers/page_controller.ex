defmodule Webdevhw07Web.PageController do
  use Webdevhw07Web, :controller

  alias Webdevhw07.Activities

  def index(conn, _params) do
    activities = Activities.list_activities()
    render(conn, "index.html", activities: activities)
  end
end
