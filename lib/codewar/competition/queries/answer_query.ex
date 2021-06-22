defmodule Codewar.Competition.Queries.AnswerQuery do
  import Ecto.Query, warn: false

  alias Codewar.Competition.Schemas.Answer

  def list_for_challenge(query \\ base(), challenge_id) do
    where(query, challenge_id: ^challenge_id)
  end

  def list_valid_for_challenge(query \\ base(), challenge_id) do
    query
    |> list_for_challenge(challenge_id)
    |> where(is_valid: true)
    |> where(is_rejected: false)
  end

  defp base do
    order_by(Answer, asc: :inserted_at)
  end
end
