defmodule CodewarWeb.Admin.DashboardRequestTest do
  use CodewarWeb.ConnCase, async: true

  describe "index/2" do
    test "responds with 200 status", %{conn: conn} do
      conn = get(conn, Routes.dashboard_path(conn, :index))

      assert conn.status == 200
    end
  end
end
