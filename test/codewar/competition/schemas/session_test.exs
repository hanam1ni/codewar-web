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
end
