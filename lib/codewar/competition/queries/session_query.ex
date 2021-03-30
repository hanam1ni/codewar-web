defmodule Codewar.Competition.Queries.SessionQuery do
  @moduledoc """
  Query functions for managing Sessions
  """

  import Ecto.Query, warn: false
  alias Codewar.Repo

  alias Codewar.Competition.Schemas.Session

  def list do
    Session
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  def get!(id), do: Repo.get!(Session, id)

  def create(attrs \\ %{}) do
    %Session{}
    |> Session.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Session{} = session, attrs) do
    session
    |> Session.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Session{} = session) do
    Repo.delete(session)
  end

  def change(%Session{} = session, attrs \\ %{}) do
    Session.changeset(session, attrs)
  end
end
