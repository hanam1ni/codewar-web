defmodule CodeWar.Competition.Schemas.ChallengeTest do
  use Codewar.DataCase, async: true

  alias Codewar.Competition.Schemas.Challenge

  describe "create_changeset/2" do
    test "returns invalid changeset if params are missing" do
      changeset = Challenge.create_changeset(%Challenge{}, %{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               name: ["can't be blank"],
               requirement: ["can't be blank"],
               answer: ["can't be blank"],
               submission_cap: ["can't be blank"],
               session_id: ["can't be blank"]
             }
    end

    test "returns invalid changeset if params are empty" do
      attrs = %{name: "", requirement: "", answer: "", submission_cap: "", session_id: ""}

      changeset = Challenge.create_changeset(%Challenge{}, attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               name: ["can't be blank"],
               requirement: ["can't be blank"],
               answer: ["can't be blank"],
               submission_cap: ["can't be blank"],
               session_id: ["can't be blank"]
             }
    end
  end

  describe "update_changeset/2" do
    test "returns invalid changeset if params are missing" do
      changeset = Challenge.create_changeset(%Challenge{}, %{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               name: ["can't be blank"],
               requirement: ["can't be blank"],
               answer: ["can't be blank"],
               submission_cap: ["can't be blank"],
               session_id: ["can't be blank"]
             }
    end

    test "returns invalid changeset if params are empty" do
      attrs = %{
        name: "",
        requirement: "",
        answer: "",
        submission_cap: "",
        session_id: ["can't be blank"]
      }

      changeset = Challenge.update_changeset(%Challenge{}, attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               name: ["can't be blank"],
               requirement: ["can't be blank"],
               answer: ["can't be blank"],
               submission_cap: ["can't be blank"],
               session_id: ["can't be blank"]
             }
    end
  end
end
