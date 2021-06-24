defmodule CodewarWeb.Admin.DashboardControllerTest do
  use CodewarWeb.ConnCase, async: true

  describe "index/2" do
    test "lists all sessions", %{conn: conn} do
      insert(:session, name: "Code War Event")

      conn = get(conn, Routes.dashboard_path(conn, :index))

      assert html_response(conn, 200) =~ "Code War Event"
    end
  end
end
