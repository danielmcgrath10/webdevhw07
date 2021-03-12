defmodule Webdevhw07Web.Router do
  use Webdevhw07Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Webdevhw07Web.Plugs.FetchSession
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Webdevhw07Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/users/profile_photo/:id", UserController, :profile_photo
    post "/invites/update_accept/:activity_id/:accept", InviteController, :update_accept
    resources "/users", UserController
    resources "/activities", ActivityController
    resources "/comments", CommentController
    resources "/invites", InviteController
    resources "/sessions", SessionController,
      only: [:create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", Webdevhw07Web do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: Webdevhw07Web.Telemetry
    end
  end
end
