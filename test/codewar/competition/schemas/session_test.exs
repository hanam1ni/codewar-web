defmodule CodeWar.Competition.Schemas.SessionTest do
  use Codewar.DataCase, async: true

  alias Codewar.Competition.Schemas.Session

  describe "changeset/2" do
    test "returns invalid changeset if params are missing" do
      changeset = Session.changeset(%Session{}, %{})

      refute changeset.valid?

      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end

    test "returns invalid changeset if params are empty" do
      attrs = %{name: ""}

      changeset = Session.changeset(%Session{}, attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end
  end

  describe "started_changeset/1" do
    test "returns a valid changeset with started_at defined" do
      changeset = Session.started_changeset(%Session{})

      assert changeset.valid?
      refute changeset.changes.started_at == nil
    end
  end

  describe "completed_changeset/1" do
    test "returns a valid changeset with completed_at defined" do
      changeset = Session.completed_changeset(%Session{})

      assert changeset.valid?
      refute changeset.changes.completed_at == nil
    end
  end

  describe "reset_changeset/1" do
    test "returns a valid changeset with started_at and completed_at reset to nil" do
      session = %Session{
        started_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
        completed_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
      }

      changeset = Session.reset_changeset(session)

      assert changeset.valid?
      assert changeset.changes.started_at == nil
      assert changeset.changes.completed_at == nil
    end
  end
end
