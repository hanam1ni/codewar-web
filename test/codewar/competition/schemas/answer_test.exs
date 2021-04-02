defmodule CodeWar.Competition.Schemas.AnswerTest do
  use Codewar.DataCase, async: true

  alias Codewar.Competition.Schemas.Answer

  describe "changeset/2" do
    test "returns invalid changeset if params are missing" do
      changeset = Answer.changeset(%Answer{}, %{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               username: ["can't be blank"],
               answer: ["can't be blank"],
               is_valid: ["can't be blank"],
               challenge_id: ["can't be blank"]
             }
    end

    test "returns invalid changeset if params are empty" do
      attrs = %{username: "", answer: "", is_valid: "", challenge_id: ""}

      changeset = Answer.changeset(%Answer{}, attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               username: ["can't be blank"],
               answer: ["can't be blank"],
               is_valid: ["can't be blank"],
               challenge_id: ["can't be blank"]
             }
    end
  end
end
