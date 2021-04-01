defmodule Codewar.Competition.Competitions do
  @moduledoc """
  The Competition context.
  """

  alias Codewar.Competition.Queries.ChallengeQuery
  alias Codewar.Competition.Queries.SessionQuery
  alias Codewar.Competition.Schemas.Challenge
  alias Codewar.Competition.Schemas.Session

  def list_sessions do
    SessionQuery.list()
  end

  def get_challenge!(id), do: ChallengeQuery.get!(id)

  def get_session!(id) do
    SessionQuery.get!(id)
  end

  def get_active_challenge do
    ChallengeQuery.get_active()
  end

  def get_active_session do
    SessionQuery.get_active()
  end

  def create_challenge(attrs \\ %{}) do
    ChallengeQuery.create(attrs)
  end

  def create_session(attrs \\ %{}) do
    SessionQuery.create(attrs)
  end

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

  def change_challenge(%Challenge{} = challenge, attrs \\ %{}) do
    ChallengeQuery.change(challenge, attrs)
  end

  def change_session(%Session{} = session, attrs \\ %{}) do
    SessionQuery.change(session, attrs)
  end
end
