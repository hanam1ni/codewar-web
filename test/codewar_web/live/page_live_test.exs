defmodule CodewarWeb.PageLiveTest do
  use CodewarWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "No active competition. Check back later."
    assert render(page_live) =~ "No active competition. Check back later."
  end
end
