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

  describe "started_changeset/1" do
    test "returns a valid changeset with started_at defined" do
      changeset = Challenge.started_changeset(%Challenge{})

      assert changeset.valid?
      refute changeset.changes.started_at == nil
    end
  end

  describe "completed_changeset/1" do
    test "returns a valid changeset with completed_at defined" do
      changeset = Challenge.completed_changeset(%Challenge{})

      assert changeset.valid?
      refute changeset.changes.completed_at == nil
    end
  end

  describe "reset_changeset/1" do
    test "returns a valid changeset with started_at and completed_at reset to nil" do
      challenge = %Challenge{
        started_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
        completed_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
      }

      changeset = Challenge.reset_changeset(challenge)

      assert changeset.valid?
      assert changeset.changes.started_at == nil
      assert changeset.changes.completed_at == nil
    end
  end
end
