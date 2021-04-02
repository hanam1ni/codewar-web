defmodule Codewar.Competition.Queries.AnswerQuery do
  @moduledoc """
  Query functions for managing Answers
  """

  import Ecto.Query, warn: false
  alias Codewar.Repo

  alias Codewar.Competition.Schemas.Answer

  def list_for_challenge(challenge_id) do
    Answer
    |> where(challenge_id: ^challenge_id)
    |> order_by(asc: :inserted_at)
    |> Repo.all()
  end

  def create(attrs \\ %{}) do
    %Answer{}
    |> Answer.changeset(attrs)
    |> Repo.insert()
  end

  def change(%Answer{} = answer, attrs \\ %{}) do
    Answer.changeset(answer, attrs)
  end
end
