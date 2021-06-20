defmodule Codewar.Competition.Queries.AnswerQuery do
  import Ecto.Query, warn: false

  alias Codewar.Competition.Schemas.Answer

  def list_for_challenge(query \\ base(), challenge_id) do
    where(query, challenge_id: ^challenge_id)
  end

  defp base do
    order_by(Answer, asc: :inserted_at)
  end
end
