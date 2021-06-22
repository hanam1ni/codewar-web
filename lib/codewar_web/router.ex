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
    if Mix.env() == :prod do
      plug :basic_auth
    end

    plug SetLayoutClassName, {:class_name, "admin"}
    plug :put_layout, {CodewarWeb.LayoutView, :admin}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CodewarWeb do
    pipe_through :browser

    live "/", Home.IndexLive, :index, as: :home
  end

  scope "/admin", CodewarWeb do
    pipe_through [:browser, :admin]

    get "/", Admin.DashboardController, :index

    resources "/challenges", Admin.ChallengeController, except: [:index, :new, :create] do
      put "/start", Admin.ChallengeController, :start
      put "/stop", Admin.ChallengeController, :stop
      put "/reset", Admin.ChallengeController, :reset
      put "/hint", Admin.ChallengeController, :enable_hint

      put "/reject/:answer_id", Admin.AnswerController, :reject
    end

    resources "/sessions", Admin.SessionController, except: [:index] do
      put "/start", Admin.SessionController, :start
      put "/stop", Admin.SessionController, :stop
      put "/reset", Admin.SessionController, :reset

      resources "/challenges", Admin.ChallengeController, only: [:new, :create]
    end
  end

  scope "/api", CodewarWeb do
    pipe_through :api

    post "/prime/:answer", Api.PrimeController, :verify_answer
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

  # Wrap method definition to avoid unused method compilation error in non :prod environments
  if Mix.env() == :prod do
    defp basic_auth(conn, _opts) do
      username = System.fetch_env!("BASIC_AUTH_USERNAME")
      password = System.fetch_env!("BASIC_AUTH_PASSWORD")
      Plug.BasicAuth.basic_auth(conn, username: username, password: password)
    end
  end
end
