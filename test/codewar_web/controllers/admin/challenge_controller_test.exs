defmodule CodewarWeb.Admin.ChallengeControllerTest do
  use CodewarWeb.ConnCase, async: true

  alias Codewar.Competition.Competitions

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

      assert conn.status == 302
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

      assert conn.status == 302
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

      assert conn.status == 302
      assert redirected_to(conn) == Routes.session_path(conn, :show, challenge.session_id)
    end
  end

  describe "start/2" do
    test "redirects given valid data", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      conn = put(conn, Routes.challenge_challenge_path(conn, :start, challenge))

      assert conn.status == 302
      assert redirected_to(conn) == Routes.session_path(conn, :show, session)
    end

    test "sets error flash and redirects given invalid data", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      expect(Competitions, :mark_challenge_as_started, fn _ ->
        {:error, %Ecto.Changeset{}}
      end)

      conn = put(conn, Routes.challenge_challenge_path(conn, :start, challenge))

      assert conn.status == 302
      assert get_flash(conn, :error) == "The challenge cannot be started."
      assert redirected_to(conn) == Routes.session_path(conn, :show, session)

      verify!()
    end
  end

  describe "stop/2" do
    test "redirects given valid data", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      conn = put(conn, Routes.challenge_challenge_path(conn, :stop, challenge))

      assert conn.status == 302
      assert redirected_to(conn) == Routes.session_path(conn, :show, session)
    end

    test "sets error flash and redirects given invalid data", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      expect(Competitions, :mark_challenge_as_completed, fn _ ->
        {:error, %Ecto.Changeset{}}
      end)

      conn = put(conn, Routes.challenge_challenge_path(conn, :stop, challenge))

      assert conn.status == 302
      assert get_flash(conn, :error) == "The challenge cannot be stopped."
      assert redirected_to(conn) == Routes.session_path(conn, :show, session)

      verify!()
    end
  end

  describe "reset/2" do
    test "redirects given valid data", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      conn = put(conn, Routes.challenge_challenge_path(conn, :reset, challenge))

      assert conn.status == 302
      assert redirected_to(conn) == Routes.session_path(conn, :show, session)
    end

    test "sets error flash and redirects given invalid data", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      expect(Competitions, :reset_challenge, fn _ ->
        {:error, %Ecto.Changeset{}}
      end)

      conn = put(conn, Routes.challenge_challenge_path(conn, :reset, challenge))

      assert conn.status == 302
      assert get_flash(conn, :error) == "The challenge cannot be reset."
      assert redirected_to(conn) == Routes.session_path(conn, :show, session)

      verify!()
    end
  end

  describe "show_hint/2" do
    test "redirects given valid data", %{conn: conn} do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      conn = post(conn, Routes.challenge_challenge_path(conn, :show_hint, challenge))

      assert conn.status == 302
      assert redirected_to(conn) == Routes.session_path(conn, :show, session)
    end
  end
end
