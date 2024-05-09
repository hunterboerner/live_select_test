defmodule LiveSelectTestWeb.Router do
  use LiveSelectTestWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveSelectTestWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveSelectTestWeb do
    pipe_through :browser

    get "/", PageController, :home

    live_session :routed do
      live "/foobars", FoobarLive.Index, :index
      live "/foobars/new", FoobarLive.Index, :new
      live "/foobars/:id/edit", FoobarLive.Index, :edit

      live "/foobars/:id", FoobarLive.Show, :show
      live "/foobars/:id/show/edit", FoobarLive.Show, :edit
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveSelectTestWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:live_select_test, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveSelectTestWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
