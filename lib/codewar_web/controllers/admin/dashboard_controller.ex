defmodule CodewarWeb.Admin.DashboardController do
  use CodewarWeb, :controller

  alias Codewar.Competition.Competitions

  def index(conn, _params) do
    sessions = Competitions.list_sessions()

    render(conn, "index.html", sessions: sessions)
  end
end
