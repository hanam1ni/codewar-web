defmodule Codewar.Competition.Queries.SessionQuery do
  @moduledoc """
  Query functions for managing Sessions
  """

  import Ecto.Query, warn: false
  alias Codewar.Repo

  alias Codewar.Competition.Schemas.Challenge
  alias Codewar.Competition.Schemas.Session

  def list do
    Session
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  def get(id) do
    challenge_query = from(c in Challenge, order_by: [asc: c.inserted_at])

    Session
    |> preload(challenges: ^challenge_query)
    |> Repo.get_by(id: id)
  end

  def get_active do
    Session
    |> where([s], not is_nil(s.started_at))
    |> where([s], is_nil(s.completed_at))
    |> Repo.one()
  end

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
