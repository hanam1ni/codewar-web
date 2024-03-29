defmodule Codewar.Competition.Schemas.Session do
  @moduledoc """
  This schema represents the Session in the Competition context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Codewar.Competition.Schemas.Challenge

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "sessions" do
    field :name, :string
    field :started_at, :naive_datetime
    field :completed_at, :naive_datetime

    has_many :challenges, Challenge

    timestamps()
  end

  def changeset(session \\ %__MODULE__{}, attrs) do
    session
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def started_changeset(%__MODULE__{} = session) do
    change(session, started_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second))
  end

  def completed_changeset(%__MODULE__{} = session) do
    change(session, completed_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second))
  end

  def reset_changeset(%__MODULE__{} = session) do
    session
    |> change(started_at: nil)
    |> change(completed_at: nil)
  end
end
