defmodule CodewarWeb.Router do
  use CodewarWeb, :router

  alias CodewarWeb.Plugs.SetLayoutClassName

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :put_root_layout, {CodewarWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug SetLayoutClassName, {:class_name, "admin"}
    plug :put_layout, {CodewarWeb.LayoutView, :admin}
  end

  scope "/", CodewarWeb do
    pipe_through :browser

    live "/", Home.IndexLive, :index, as: :home
  end

  scope "/admin/", CodewarWeb do
    pipe_through [:browser, :admin]

    get "/", Admin.DashboardController, :index

    resources "/challenges", Admin.ChallengeController, except: [:index, :new, :create]

    resources "/sessions", Admin.SessionController, except: [:index] do
      resources "/challenges", Admin.ChallengeController, only: [:new, :create]
    end
  end

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
      # coveralls-ignore-start
      live_dashboard "/dashboard", metrics: CodewarWeb.Telemetry
      # coveralls-ignore-stop
    end
  end
end
