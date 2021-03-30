defmodule Codewar.Competition.Competitions do
  @moduledoc """
  The Competition context.
  """

  alias Codewar.Competition.Queries.SessionQuery
  alias Codewar.Competition.Schemas.Session

  def list_sessions do
    SessionQuery.list()
  end

  def get_session!(id), do: SessionQuery.get!(id)

  def create_session(attrs \\ %{}) do
    SessionQuery.create(attrs)
  end

  def update_session(%Session{} = session, attrs) do
    SessionQuery.update(session, attrs)
  end

  def delete_session(%Session{} = session) do
    SessionQuery.delete(session)
  end

  def change_session(%Session{} = session, attrs \\ %{}) do
    SessionQuery.change(session, attrs)
  end
end
