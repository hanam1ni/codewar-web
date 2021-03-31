defmodule Codewar.Competition.Queries.ChallengeQuery do
  @moduledoc """
  Query functions for managing Challenges
  """

  import Ecto.Query, warn: false
  alias Codewar.Repo

  alias Codewar.Competition.Schemas.Challenge

  def get!(id), do: Repo.get!(Challenge, id)

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
end
