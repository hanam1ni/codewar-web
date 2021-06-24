defmodule Codewar.Competition.Queries.ChallengeQuery do
  import Ecto.Query, warn: false

  alias Codewar.Competition.Schemas.Challenge

  def list_active(query \\ base()) do
    query
    |> where([challenge], not is_nil(challenge.started_at))
    |> where([challenge], is_nil(challenge.completed_at))
  end

  defp base, do: Challenge
end
