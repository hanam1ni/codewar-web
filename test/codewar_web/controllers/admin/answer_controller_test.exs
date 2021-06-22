defmodule CodewarWeb.Admin.AnswerControllerTest do
  use CodewarWeb.ConnCase, async: true

  alias Codewar.Competition.Competitions

  describe "reject/2" do
    test "redirects given valid params", %{conn: conn} do
      challenge = insert(:challenge, session: build(:session))
      answer = insert(:answer, challenge_id: challenge.id)

      conn = put(conn, Routes.challenge_answer_path(conn, :reject, challenge, answer))

      assert redirected_to(conn) == Routes.challenge_path(conn, :show, challenge)
    end

    test "sets error flash and redirects given invalid params", %{conn: conn} do
      challenge = insert(:challenge, session: build(:session))
      answer = insert(:answer, challenge_id: challenge.id)

      expect(Competitions, :reject_answer, fn _ ->
        {:error, %Ecto.Changeset{}}
      end)

      conn = put(conn, Routes.challenge_answer_path(conn, :reject, challenge, answer))

      assert conn.status == 302
      assert get_flash(conn, :error) == "The answer cannot be rejected."
      assert redirected_to(conn) == Routes.challenge_path(conn, :show, challenge)

      verify!()
    end
  end
end
