defmodule Codewar.Competition.Schemas.Challenge do
  @moduledoc """
  This schema represents the Challenge in the Competition context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Codewar.Competition.Schemas.Answer
  alias Codewar.Competition.Schemas.Session

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "challenges" do
    field :name, :string
    field :requirement, :string
    field :hint, :string
    field :answer, :string
    field :submission_cap, :integer
    field :started_at, :naive_datetime
    field :completed_at, :naive_datetime

    belongs_to :session, Session, foreign_key: :session_id
    has_many :answers, Answer

    timestamps()
  end

  def changeset(challenge \\ %__MODULE__{}, attrs) do
    challenge
    |> cast(attrs, [:name, :requirement, :hint, :answer, :submission_cap, :session_id])
    |> validate_required([:name, :requirement, :answer, :submission_cap, :session_id])
    |> assoc_constraint(:session)
  end

  def started_changeset(%__MODULE__{} = challenge) do
    change(challenge, started_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second))
  end

  def completed_changeset(%__MODULE__{} = challenge) do
    change(challenge, completed_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second))
  end

  def reset_changeset(%__MODULE__{} = challenge) do
    challenge
    |> change(started_at: nil)
    |> change(completed_at: nil)
  end
end
