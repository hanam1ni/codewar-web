defmodule Codewar.Competition.Schemas.Answer do
  @moduledoc """
  This schema represents the Answer in the Competition context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Codewar.Competition.Schemas.Challenge

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "answers" do
    field :username, :string
    field :answer, :string
    field :is_valid, :boolean

    belongs_to :challenge, Challenge, foreign_key: :challenge_id

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:username, :answer, :is_valid, :challenge_id])
    |> validate_required([:username, :answer, :is_valid, :challenge_id])
    |> assoc_constraint(:challenge)
  end
end
