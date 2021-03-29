defmodule CodewarWeb.LayoutViewTest do
  use CodewarWeb.ConnCase, async: true

  alias Plug.Conn

  alias CodewarWeb.LayoutView

  # Phoenix.Naming.resource_name requires a valid module
  # Using the module under test not to have any dependency
  describe "page_class_name/1" do
    test "returns page class names given a live view", %{conn: conn} do
      conn =
        conn
        |> Conn.assign(:live_action, :index)
        |> Conn.assign(:live_module, CodewarWeb.LayoutView)

      assert LayoutView.page_class_name(conn) == "layout-view index"
    end

    test "returns page class names given a controller-based view", %{conn: conn} do
      conn =
        conn
        |> Conn.put_private(:phoenix_action, :index)
        |> Conn.put_private(:phoenix_controller, CodewarWeb.LayoutView)

      assert LayoutView.page_class_name(conn) == "layout-view index"
    end
  end
end
