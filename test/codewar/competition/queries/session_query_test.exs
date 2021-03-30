defmodule Codewar.Competition.Queries.SessionQueryTest do
  use Codewar.DataCase, async: true

  alias Codewar.Competition.Queries.SessionQuery
  alias Codewar.Competition.Schemas.Session

  describe "list/0" do
    test "returns all sessions in descending order of creation" do
      first_session = insert(:session)
      second_session = insert(:session, inserted_at: NaiveDateTime.add(NaiveDateTime.utc_now(), 1))

      assert SessionQuery.list() == [second_session, first_session]
    end
  end

  describe "get!/1" do
    test "returns the session with given id" do
      session = insert(:session)

      assert SessionQuery.get!(session.id) == session
    end
  end

  describe "create/1" do
    test "creates a session given valid data" do
      valid_attrs = %{name: "Test session"}

      assert {:ok, %Session{} = session} = SessionQuery.create(valid_attrs)
      assert session.name == "Test session"
    end

    test "returns error changeset given invalid data" do
      invalid_attrs = %{name: ""}

      assert {:error, %Ecto.Changeset{}} = SessionQuery.create(invalid_attrs)
    end
  end

  describe "update/2" do
    test "updates the session given valid data " do
      session = insert(:session, name: "Test session")
      valid_attrs = %{name: "Updated test session"}

      assert {:ok, %Session{} = session} = SessionQuery.update(session, valid_attrs)
      assert session.name == "Updated test session"
    end

    test "returns error changeset given invalid data" do
      session = insert(:session)
      invalid_attrs = %{name: ""}

      assert {:error, %Ecto.Changeset{}} = SessionQuery.update(session, invalid_attrs)
    end
  end

  describe "delete/1" do
    test "deletes the session" do
      session = insert(:session)

      assert {:ok, %Session{}} = SessionQuery.delete(session)
    end
  end

  describe "change/1" do
    test "returns a session changeset" do
      session = insert(:session)

      assert %Ecto.Changeset{} = SessionQuery.change(session)
    end
  end
end
