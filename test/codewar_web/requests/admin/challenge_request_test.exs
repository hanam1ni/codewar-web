defmodule CodewarWeb.Admin.ChallengeRequestTest do
  use CodewarWeb.ConnCase, async: true

  describe "get new/2" do
    test "responds with 200 status", %{conn: conn} do
      session = insert(:session)

      conn = get(conn, Routes.session_challenge_path(conn, :new, session))

      assert conn.status == 200
    end
  end

  describe "create/2" do
    test "responds with 302 redirect status given valid data", %{conn: conn} do
      session = insert(:session)
      valid_attrs = params_for(:challenge, session_id: session.id)

      conn =
        post(conn, Routes.session_challenge_path(conn, :create, session), challenge: valid_attrs)

      assert conn.status == 302
    end

    test "renders errors given invalid data", %{conn: conn} do
      session = insert(:session)
      invalid_attrs = %{name: ""}

      conn =
        post(conn, Routes.session_challenge_path(conn, :create, session), challenge: invalid_attrs)

      assert conn.status == 200
    end
  end

  describe "get show/2" do
    test "responds with 200 status given a valid challenge", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      conn = get(conn, Routes.challenge_path(conn, :show, challenge))

      assert conn.status == 200
    end
  end

  describe "get edit/2" do
    test "responds with 200 status given a valid challenge", %{conn: conn} do
      challenge = insert(:challenge)

      conn = get(conn, Routes.challenge_path(conn, :edit, challenge))

      assert conn.status == 200
    end
  end

  describe "patch update/2" do
    test "responds with 302 redirect status given valid data", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, name: "Test challenge", session_id: session.id)
      valid_attrs = %{name: "Updated test challenge"}

      conn = put(conn, Routes.challenge_path(conn, :update, challenge), challenge: valid_attrs)

      assert conn.status == 302
    end

    test "responds with 200 status given invalid data", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)
      invalid_attrs = %{name: ""}

      conn = put(conn, Routes.challenge_path(conn, :update, challenge), challenge: invalid_attrs)

      assert conn.status == 200
    end
  end

  describe "delete delete/2" do
    test "responds with 302 redirect status", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      conn = delete(conn, Routes.challenge_path(conn, :delete, challenge))

      assert conn.status == 302
    end
  end
end
