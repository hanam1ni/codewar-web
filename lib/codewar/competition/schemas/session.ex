defmodule Codewar.Competition.Schemas.Session do
  @moduledoc """
  This schema represents the Session in the Competition context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "sessions" do
    field :name, :string
    field :started_at, :naive_datetime
    field :completed_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
