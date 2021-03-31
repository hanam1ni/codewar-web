defmodule CodewarWeb.Admin.SessionControllerTest do
  use CodewarWeb.ConnCase, async: true

  describe "new/2" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))

      assert html_response(conn, 200) =~ "New Session"
    end
  end

  describe "create/2" do
    test "redirects to show given valid data", %{conn: conn} do
      valid_attrs = %{name: "Test session"}

      conn = post(conn, Routes.session_path(conn, :create), session: valid_attrs)

      assert %{id: session_id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.session_path(conn, :show, session_id)
    end

    test "renders errors given invalid data", %{conn: conn} do
      invalid_attrs = %{name: ""}

      conn = post(conn, Routes.session_path(conn, :create), session: invalid_attrs)

      assert html_response(conn, 200) =~ "New Session"
    end
  end

  describe "show/2" do
    test "renders the session details", %{conn: conn} do
      session = insert(:session, name: "Test Session")

      conn = get(conn, Routes.session_path(conn, :show, session))

      assert html_response(conn, 200) =~ "Test Session"
    end
  end

  describe "edit/2" do
    test "renders form for editing chosen session", %{conn: conn} do
      session = insert(:session)

      conn = get(conn, Routes.session_path(conn, :edit, session))

      assert html_response(conn, 200) =~ "Edit Session"
    end
  end

  describe "update/2" do
    test "redirects given valid data", %{conn: conn} do
      session = insert(:session, name: "Test session")
      valid_attrs = %{name: "Updated test session"}

      conn = put(conn, Routes.session_path(conn, :update, session), session: valid_attrs)

      assert redirected_to(conn) == Routes.session_path(conn, :show, session)
    end

    test "renders errors given invalid data", %{conn: conn} do
      session = insert(:session)
      invalid_attrs = %{name: ""}

      conn = put(conn, Routes.session_path(conn, :update, session), session: invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Session"
    end
  end

  describe "delete/2" do
    test "redirects given a valid session", %{conn: conn} do
      session = insert(:session)

      conn = delete(conn, Routes.session_path(conn, :delete, session))

      assert redirected_to(conn) == Routes.dashboard_path(conn, :index)
    end

    test "deletes the session given a valid session", %{conn: conn} do
      session = insert(:session)

      conn = delete(conn, Routes.session_path(conn, :delete, session))

      assert_error_sent 404, fn ->
        get(conn, Routes.session_path(conn, :show, session))
      end
    end
  end
end