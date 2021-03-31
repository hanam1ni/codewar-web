defmodule CodewarWeb.Admin.ChallengeControllerTest do
  use CodewarWeb.ConnCase, async: true

  describe "new/2" do
    test "renders form", %{conn: conn} do
      session = insert(:session)

      conn = get(conn, Routes.session_challenge_path(conn, :new, session))

      assert html_response(conn, 200) =~ "New Challenge"
    end
  end

  describe "create/2" do
    test "redirects to show given valid data", %{conn: conn} do
      session = insert(:session)
      valid_attrs = params_for(:challenge, session_id: session.id)

      conn =
        post(conn, Routes.session_challenge_path(conn, :create, session), challenge: valid_attrs)

      assert %{id: challenge_id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.challenge_path(conn, :show, challenge_id)
    end

    test "renders errors given invalid data", %{conn: conn} do
      session = insert(:session)
      invalid_attrs = %{name: "", requirement: "", hint: "", answer: "", session_id: session.id}

      conn =
        post(conn, Routes.session_challenge_path(conn, :create, session), challenge: invalid_attrs)

      assert html_response(conn, 200) =~ "New Challenge"
    end
  end

  describe "show/2" do
    test "renders the session details", %{conn: conn} do
      challenge = insert(:challenge, name: "Test Challenge", session: build(:session))

      conn = get(conn, Routes.challenge_path(conn, :show, challenge))

      assert html_response(conn, 200) =~ "Test Challenge"
    end
  end

  describe "edit/2" do
    test "renders form for editing chosen session", %{conn: conn} do
      challenge = insert(:challenge)

      conn = get(conn, Routes.challenge_path(conn, :edit, challenge))

      assert html_response(conn, 200) =~ "Edit Challenge"
    end
  end

  describe "update/2" do
    test "redirects given valid data", %{conn: conn} do
      challenge = insert(:challenge, name: "Test Challenge", session: build(:session))
      valid_attrs = %{name: "Updated test challenge"}

      conn = put(conn, Routes.challenge_path(conn, :update, challenge), challenge: valid_attrs)

      assert redirected_to(conn) == Routes.challenge_path(conn, :show, challenge)
    end

    test "renders errors given invalid data", %{conn: conn} do
      challenge = insert(:challenge, session: build(:session))
      invalid_attrs = %{name: ""}

      conn = put(conn, Routes.challenge_path(conn, :update, challenge), challenge: invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Challenge"
    end
  end

  describe "delete/2" do
    test "redirects given a valid challenge", %{conn: conn} do
      challenge = insert(:challenge, session: build(:session))

      conn = delete(conn, Routes.challenge_path(conn, :delete, challenge))

      assert redirected_to(conn) == Routes.session_path(conn, :show, challenge.session_id)
    end

    test "deletes the session given a valid session", %{conn: conn} do
      challenge = insert(:challenge, session: build(:session))

      conn = delete(conn, Routes.challenge_path(conn, :delete, challenge))

      assert_error_sent 404, fn ->
        get(conn, Routes.challenge_path(conn, :show, challenge))
      end
    end
  end
end