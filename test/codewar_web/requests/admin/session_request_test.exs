defmodule CodewarWeb.Admin.SessionRequestTest do
  use CodewarWeb.ConnCase, async: true

  alias Codewar.Competition.Competitions

  describe "get new/2" do
    test "responds with 200 status", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))

      assert conn.status == 200
    end
  end

  describe "post create/2" do
    test "responds with 302 redirect status given valid data", %{conn: conn} do
      valid_attrs = %{name: "Test session"}

      conn = post(conn, Routes.session_path(conn, :create), session: valid_attrs)

      assert conn.status == 302
    end

    test "renders errors given invalid data", %{conn: conn} do
      invalid_attrs = %{name: ""}

      conn = post(conn, Routes.session_path(conn, :create), session: invalid_attrs)

      assert conn.status == 200
    end
  end

  describe "get show/2" do
    test "responds with 200 status given a valid session", %{conn: conn} do
      session = insert(:session, name: "Test Session")

      conn = get(conn, Routes.session_path(conn, :show, session))

      assert conn.status == 200
    end
  end

  describe "get edit/2" do
    test "responds with 200 status given a valid session", %{conn: conn} do
      session = insert(:session)

      conn = get(conn, Routes.session_path(conn, :edit, session))

      assert conn.status == 200
    end
  end

  describe "patch update/2" do
    test "responds with 302 redirect status given valid data", %{conn: conn} do
      session = insert(:session, name: "Test session")
      valid_attrs = %{name: "Updated test session"}

      conn = put(conn, Routes.session_path(conn, :update, session), session: valid_attrs)

      assert conn.status == 302
    end

    test "responds with 200 status given invalid data", %{conn: conn} do
      session = insert(:session)
      invalid_attrs = %{name: ""}

      conn = put(conn, Routes.session_path(conn, :update, session), session: invalid_attrs)

      assert conn.status == 200
    end
  end

  describe "delete delete/2" do
    test "responds with 302 redirect status", %{conn: conn} do
      session = insert(:session)

      conn = delete(conn, Routes.session_path(conn, :delete, session))

      assert conn.status == 302
    end
  end

  describe "patch start/2" do
    test "responds with 302 redirect status given valid data", %{conn: conn} do
      session = insert(:session)

      conn = put(conn, Routes.session_session_path(conn, :start, session))

      assert conn.status == 302
    end

    test "responds with 302 redirect status given invalid data", %{conn: conn} do
      session = insert(:session)

      expect(Competitions, :mark_session_as_started, fn _ ->
        {:error, %Ecto.Changeset{}}
      end)

      conn = put(conn, Routes.session_session_path(conn, :start, session))

      assert conn.status == 302

      verify!()
    end
  end

  describe "patch stop/2" do
    test "responds with 302 redirect status given valid data", %{conn: conn} do
      session = insert(:session)

      conn = put(conn, Routes.session_session_path(conn, :stop, session))

      assert conn.status == 302
    end

    test "responds with 302 redirect status given invalid data", %{conn: conn} do
      session = insert(:session)

      expect(Competitions, :mark_session_as_completed, fn _ ->
        {:error, %Ecto.Changeset{}}
      end)

      conn = put(conn, Routes.session_session_path(conn, :stop, session))

      assert conn.status == 302

      verify!()
    end
  end

  describe "pathc reset/2" do
    test "responds with 302 redirect status given valid data", %{conn: conn} do
      session = insert(:session)

      conn = put(conn, Routes.session_session_path(conn, :reset, session))

      assert conn.status == 302
    end

    test "responds with 302 redirect status given invalid data", %{conn: conn} do
      session = insert(:session)

      expect(Competitions, :reset_session, fn _ ->
        {:error, %Ecto.Changeset{}}
      end)

      conn = put(conn, Routes.session_session_path(conn, :reset, session))

      assert conn.status == 302

      verify!()
    end
  end
end
