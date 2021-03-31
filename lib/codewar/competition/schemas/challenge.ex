defmodule Codewar.Competition.Schemas.Challenge do
  @moduledoc """
  This schema represents the Challenge in the Competition context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Codewar.Competition.Schemas.Session

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "challenges" do
    field :name, :string
    field :requirement, :string, null: false
    field :hint, :string
    field :answer, :string
    field :submission_cap, :integer
    field :started_at, :naive_datetime
    field :completed_at, :naive_datetime

    belongs_to :session, Session, foreign_key: :session_id

    timestamps()
  end

  @doc false
  def create_changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:name, :requirement, :hint, :answer, :submission_cap, :session_id])
    |> validate_required([:name, :requirement, :answer, :submission_cap, :session_id])
    |> assoc_constraint(:session)
  end

  @doc false
  def update_changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:name, :requirement, :hint, :answer, :submission_cap])
    |> validate_required([:name, :requirement, :answer, :submission_cap, :session_id])
  end
end