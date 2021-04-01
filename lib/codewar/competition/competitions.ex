defmodule Codewar.Competition.Competitions do
  @moduledoc """
  The Competition context.
  """

  alias Codewar.Competition.Queries.AnswerQuery
  alias Codewar.Competition.Queries.ChallengeQuery
  alias Codewar.Competition.Queries.SessionQuery
  alias Codewar.Competition.Schemas.Answer
  alias Codewar.Competition.Schemas.Challenge
  alias Codewar.Competition.Schemas.Session

  def list_sessions do
    SessionQuery.list()
  end

  def get_challenge(id), do: ChallengeQuery.get(id)

  def get_session(id), do: SessionQuery.get(id)

  def get_active_challenge, do: ChallengeQuery.get_active()

  def get_active_session, do: SessionQuery.get_active()

  def validate_and_create_answer(%{"challenge_id" => challenge_id, "answer" => answer} = attrs) do
    with %Challenge{} = challenge <- get_challenge(challenge_id),
         is_valid <- challenge.answer == answer,
         {:ok, %Answer{} = created_answer} <-
           AnswerQuery.create(Map.put(attrs, "is_valid", is_valid)) do
      {:ok, created_answer}
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}

      nil ->
        {:error, :invalid_challenge}
    end
  end

  def create_challenge(attrs \\ %{}), do: ChallengeQuery.create(attrs)

  def create_session(attrs \\ %{}), do: SessionQuery.create(attrs)

  def update_challenge(%Challenge{} = challenge, attrs) do
    ChallengeQuery.update(challenge, attrs)
  end

  def update_session(%Session{} = session, attrs) do
    SessionQuery.update(session, attrs)
  end

  def delete_challenge(%Challenge{} = challenge) do
    ChallengeQuery.delete(challenge)
  end

  def delete_session(%Session{} = session) do
    SessionQuery.delete(session)
  end

  def change_answer(%Answer{} = answer, attrs \\ %{}) do
    AnswerQuery.change(answer, attrs)
  end

  def change_challenge(%Challenge{} = challenge, attrs \\ %{}) do
    ChallengeQuery.change(challenge, attrs)
  end

  def change_session(%Session{} = session, attrs \\ %{}) do
    SessionQuery.change(session, attrs)
  end

  def mark_session_as_started(%Session{} = session) do
    SessionQuery.mark_as_started(session)
  end

  def mark_session_as_completed(%Session{} = session) do
    SessionQuery.mark_as_completed(session)
  end

  def reset_session(%Session{} = session) do
    SessionQuery.reset(session)
  end
end
