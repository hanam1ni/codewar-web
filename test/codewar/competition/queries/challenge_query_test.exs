defmodule Codewar.Competition.Queries.ChallengeQueryTest do
  use Codewar.DataCase, async: true

  alias Codewar.Competition.Queries.ChallengeQuery
  alias Codewar.Competition.Schemas.Challenge

  describe "get_by/1" do
    test "returns the challenge with given id" do
      challenge = insert(:challenge)

      assert ChallengeQuery.get(challenge.id) == challenge
    end
  end

  describe "get_active/0" do
    test "returns the started but not yet completed challenge" do
      challenge = insert(:challenge, started_at: NaiveDateTime.utc_now(), completed_at: nil)

      assert ChallengeQuery.get_active() == challenge
    end

    test "does NOT return completed challenges" do
      _completed_challenge =
        insert(:challenge,
          started_at: NaiveDateTime.utc_now(),
          completed_at: NaiveDateTime.utc_now()
        )

      assert ChallengeQuery.get_active() == nil
    end
  end

  describe "create/1" do
    test "creates a challenge given valid data" do
      session = insert(:session)
      valid_attrs = params_for(:challenge, name: "Test challenge", session_id: session.id)

      assert {:ok, %Challenge{} = challenge} = ChallengeQuery.create(valid_attrs)
      assert challenge.name == "Test challenge"
    end

    test "returns error changeset given invalid data" do
      invalid_attrs = %{name: ""}

      assert {:error, %Ecto.Changeset{}} = ChallengeQuery.create(invalid_attrs)
    end
  end

  describe "update/2" do
    test "updates the challenge given valid data " do
      session = insert(:session)
      challenge = insert(:challenge, name: "Test challenge", session_id: session.id)
      valid_attrs = %{name: "Updated test challenge"}

      assert {:ok, %Challenge{} = challenge} = ChallengeQuery.update(challenge, valid_attrs)
      assert challenge.name == "Updated test challenge"
    end

    test "returns error changeset given invalid data" do
      challenge = insert(:challenge)
      invalid_attrs = %{name: ""}

      assert {:error, %Ecto.Changeset{}} = ChallengeQuery.update(challenge, invalid_attrs)
    end
  end

  describe "delete/1" do
    test "deletes the challenge" do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      assert {:ok, %Challenge{}} = ChallengeQuery.delete(challenge)
    end
  end

  describe "change/1" do
    test "returns a create challenge changeset given an empty challenge struct" do
      assert %Ecto.Changeset{} = ChallengeQuery.change(%Challenge{})
    end

    test "returns an update challenge changeset given an existing challenge" do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      assert %Ecto.Changeset{} = ChallengeQuery.change(challenge)
    end
  end

  describe "mark_as_started/1" do
    test "updates the challenge started_at" do
      challenge = insert(:challenge, started_at: nil, session: build(:session))

      assert {:ok, %Challenge{} = challenge} = ChallengeQuery.mark_as_started(challenge)
      refute challenge.started_at == nil
    end
  end

  describe "mark_as_completed/1" do
    test "updates the challenge completed_at" do
      challenge = insert(:challenge, completed_at: nil, session: build(:session))

      assert {:ok, %Challenge{} = challenge} = ChallengeQuery.mark_as_completed(challenge)
      refute challenge.completed_at == nil
    end
  end

  describe "reset/1" do
    test "resets the challenge started_at and completed_at" do
      challenge =
        insert(:challenge,
          started_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
          completed_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
          session: build(:session)
        )

      assert {:ok, %Challenge{} = challenge} = ChallengeQuery.reset(challenge)
      assert challenge.started_at == nil
      assert challenge.completed_at == nil
    end
  end
end
