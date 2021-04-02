defmodule Codewar.Competition.Queries.ChallengeQuery do
  @moduledoc """
  Query functions for managing Challenges
  """

  import Ecto.Query, warn: false
  alias Codewar.Repo

  alias Codewar.Competition.Schemas.Challenge

  def get(id), do: Repo.get_by(Challenge, id: id)

  def get_active do
    Challenge
    |> where([c], not is_nil(c.started_at))
    |> where([c], is_nil(c.completed_at))
    |> Repo.one()
  end

  def create(attrs \\ %{}) do
    %Challenge{}
    |> Challenge.create_changeset(attrs)
    |> Repo.insert()
  end

  def update(%Challenge{} = challenge, attrs) do
    challenge
    |> Challenge.update_changeset(attrs)
    |> Repo.update()
  end

  def delete(%Challenge{} = challenge) do
    Repo.delete(challenge)
  end

  def change(challenge, attrs \\ %{})

  def change(%Challenge{} = challenge, attrs) when is_nil(challenge.session_id) do
    Challenge.create_changeset(challenge, attrs)
  end

  def change(%Challenge{} = challenge, attrs) do
    Challenge.update_changeset(challenge, attrs)
  end

  def mark_as_started(%Challenge{} = challenge) do
    challenge
    |> Challenge.started_changeset()
    |> Repo.update()
  end

  def mark_as_completed(%Challenge{} = challenge) do
    challenge
    |> Challenge.completed_changeset()
    |> Repo.update()
  end

  def reset(%Challenge{} = challenge) do
    challenge
    |> Challenge.reset_changeset()
    |> Repo.update()
  end
end
