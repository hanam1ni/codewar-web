defmodule Codewar.Competition.Queries.AnswerQuery do
  @moduledoc """
  Query functions for managing Answers
  """

  import Ecto.Query, warn: false
  alias Codewar.Repo

  alias Codewar.Competition.Schemas.Answer

  def create(attrs \\ %{}) do
    %Answer{}
    |> Answer.changeset(attrs)
    |> Repo.insert()
  end

  def change(%Answer{} = answer, attrs \\ %{}) do
    Answer.changeset(answer, attrs)
  end
end
