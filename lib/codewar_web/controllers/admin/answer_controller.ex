defmodule CodewarWeb.Admin.AnswerController do
  use CodewarWeb, :controller

  alias Codewar.Competition.Competitions
  alias CodewarWeb.Channels.CompetitionChannel

  def reject(conn, %{
        "challenge_id" => challenge_id,
        "answer_id" => answer_id
      }) do
    challenge = Competitions.get_challenge(challenge_id)
    answer = Competitions.get_answer(answer_id)

    case Competitions.reject_answer(answer) do
      {:ok, _answer} ->
        CompetitionChannel.notify_subscribers(:rejected_answer, challenge)

        conn
        |> put_flash(:info, "Answer rejected successfully.")
        |> redirect(to: Routes.challenge_path(conn, :show, challenge))

      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, "The answer cannot be rejected.")
        |> redirect(to: Routes.challenge_path(conn, :show, challenge))
    end
  end
end
