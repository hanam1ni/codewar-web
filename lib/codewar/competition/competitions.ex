defmodule Codewar.Competition.Competitions do
  alias Codewar.Repo

  alias Codewar.Competition.Queries.AnswerQuery
  alias Codewar.Competition.Queries.ChallengeQuery
  alias Codewar.Competition.Queries.SessionQuery
  alias Codewar.Competition.Schemas.Answer
  alias Codewar.Competition.Schemas.Challenge
  alias Codewar.Competition.Schemas.Session

  def list_sessions, do: Repo.all(SessionQuery.list())

  def get_session(id) do
    Session
    |> SessionQuery.with_challenges()
    |> Repo.get_by(id: id)
  end

  def get_active_session, do: Repo.one(SessionQuery.list_active())

  def create_session(attrs \\ %{}),
    do: %Session{} |> Session.changeset(attrs) |> Repo.insert()

  def update_session(%Session{} = session, attrs),
    do: session |> Session.changeset(attrs) |> Repo.update()

  def delete_session(%Session{} = session), do: Repo.delete(session)

  def mark_session_as_started(%Session{} = session),
    do: session |> Session.started_changeset() |> Repo.update()

  def mark_session_as_completed(%Session{} = session),
    do: session |> Session.completed_changeset() |> Repo.update()

  def reset_session(%Session{} = session),
    do: session |> Session.reset_changeset() |> Repo.update()

  def get_challenge(id), do: Repo.get_by(Challenge, id: id)

  def get_active_challenge, do: Repo.one(ChallengeQuery.list_active())

  def create_challenge(attrs \\ %{}),
    do: %Challenge{} |> Challenge.changeset(attrs) |> Repo.insert()

  def update_challenge(%Challenge{} = challenge, attrs),
    do: challenge |> Challenge.changeset(attrs) |> Repo.update()

  def delete_challenge(%Challenge{} = challenge), do: Repo.delete(challenge)

  def mark_challenge_as_started(%Challenge{} = challenge),
    do: challenge |> Challenge.started_changeset() |> Repo.update()

  def mark_challenge_as_completed(%Challenge{} = challenge),
    do: challenge |> Challenge.completed_changeset() |> Repo.update()

  def reset_challenge(%Challenge{} = challenge),
    do: challenge |> Challenge.reset_changeset() |> Repo.update()

  def enable_challenge_hint(%Challenge{} = challenge),
    do: challenge |> Challenge.hint_enabled_changeset() |> Repo.update()

  def list_challenge_answers(challenge_id),
    do: Repo.all(AnswerQuery.list_for_challenge(challenge_id))

  def list_valid_challenge_answers(challenge_id),
    do: Repo.all(AnswerQuery.list_valid_for_challenge(challenge_id))

  def get_answer(id), do: Repo.get_by(Answer, id: id)

  def create_answer(attrs \\ %{}),
    do: %Answer{} |> Answer.changeset(attrs) |> Repo.insert()

  def validate_and_create_answer(%{"challenge_id" => challenge_id, "answer" => answer} = attrs) do
    with %Challenge{} = challenge <- get_challenge(challenge_id),
         {:ok, _remaining_answer_slot} <- verify_submission_cap_for(challenge),
         is_valid <- challenge.answer == answer,
         {:ok, %Answer{} = created_answer} <-
           create_answer(Map.put(attrs, "is_valid", is_valid)) do
      {:ok, created_answer}
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}

      {:error, :submission_cap_reached} ->
        {:error, :submission_cap_reached}

      nil ->
        {:error, :invalid_challenge}
    end
  end

  def reject_answer(%Answer{} = answer),
    do: answer |> Answer.rejected_changeset() |> Repo.update()

  defp verify_submission_cap_for(challenge) do
    valid_answers = list_valid_challenge_answers(challenge.id)
    valid_answers_count = Enum.count(valid_answers)
    remaining_answer_slots = challenge.submission_cap - valid_answers_count

    if valid_answers_count < challenge.submission_cap do
      {:ok, remaining_answer_slots}
    else
      {:error, :submission_cap_reached}
    end
  end
end
