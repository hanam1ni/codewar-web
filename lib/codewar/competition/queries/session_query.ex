defmodule Codewar.Competition.Queries.SessionQuery do
  import Ecto.Query, warn: false

  alias Codewar.Competition.Schemas.Challenge
  alias Codewar.Competition.Schemas.Session

  def list(query \\ base()) do
    order_by(query, asc: :inserted_at)
  end

  def list_active(query \\ base()) do
    query
    |> where([session], not is_nil(session.started_at))
    |> where([session], is_nil(session.completed_at))
  end

  def with_challenges(query \\ base()) do
    challenge_query = from(challenge in Challenge, order_by: [asc: challenge.inserted_at])

    preload(query, challenges: ^challenge_query)
  end

  defp base, do: Session
end
