defmodule Codewar.Competition.Queries.AnswerQueryTest do
  use Codewar.DataCase, async: true

  alias Codewar.Competition.Queries.AnswerQuery
  alias Codewar.Competition.Schemas.Answer

  describe "list_for_challenge/1" do
    test "returns all answers for a challenge in ascending order of creation" do
      challenge = insert(:challenge, session: build(:session))
      first_answer = insert(:answer, challenge_id: challenge.id)

      second_answer =
        insert(:answer,
          challenge_id: challenge.id,
          inserted_at: NaiveDateTime.add(NaiveDateTime.utc_now(), 1)
        )

      assert AnswerQuery.list_for_challenge(challenge.id) == [first_answer, second_answer]
    end
  end

  describe "create/1" do
    test "creates an answer given valid data" do
      challenge = insert(:challenge, session: build(:session))
      valid_attrs = params_for(:answer, answer: "42", challenge_id: challenge.id)

      assert {:ok, %Answer{} = answer} = AnswerQuery.create(valid_attrs)
      assert answer.answer == "42"
    end

    test "returns error changeset given invalid data" do
      invalid_attrs = %{username: "", answer: "", is_valid: "", challenge_id: ""}

      assert {:error, %Ecto.Changeset{}} = AnswerQuery.create(invalid_attrs)
    end
  end

  describe "change/1" do
    test "returns an answer changeset" do
      answer = insert(:answer)

      assert %Ecto.Changeset{} = AnswerQuery.change(answer)
    end
  end
end
