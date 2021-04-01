defmodule Codewar.Competition.SessionsTest do
  use Codewar.DataCase, async: true

  alias Codewar.Competition.Competitions
  alias Codewar.Competition.Schemas.Answer
  alias Codewar.Competition.Schemas.Challenge
  alias Codewar.Competition.Schemas.Session

  describe "list_sessions/0" do
    test "returns all sessions" do
      session = insert(:session)

      assert Competitions.list_sessions() == [session]
    end
  end

  describe "get_challenge/1" do
    test "returns the challenge with given id" do
      challenge = insert(:challenge, name: "Test session")

      assert Competitions.get_challenge(challenge.id) == challenge
    end
  end

  describe "get_session/1" do
    test "returns the session with given id" do
      session = insert(:session, challenges: [build(:challenge)])

      assert Competitions.get_session(session.id) == session
    end

    test "returns the challenges for the session" do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)

      session_from_db = Competitions.get_session(session.id)

      assert session_from_db.challenges == [challenge]
    end
  end

  describe "get_active_challenge/0" do
    test "returns the started but not yet completed challenge" do
      challenge = insert(:challenge, started_at: NaiveDateTime.utc_now(), completed_at: nil)

      assert Competitions.get_active_challenge() == challenge
    end

    test "does NOT return completed challenges" do
      _completed_challenge =
        insert(:challenge,
          started_at: NaiveDateTime.utc_now(),
          completed_at: NaiveDateTime.utc_now()
        )

      assert Competitions.get_active_challenge() == nil
    end
  end

  describe "get_active_session/0" do
    test "returns the started but not yet completed session" do
      session = insert(:session, started_at: NaiveDateTime.utc_now(), completed_at: nil)

      assert Competitions.get_active_session() == session
    end

    test "does NOT return completed sessions" do
      _completed_session =
        insert(:session, started_at: NaiveDateTime.utc_now(), completed_at: NaiveDateTime.utc_now())

      assert Competitions.get_active_session() == nil
    end
  end

  describe "validate_and_create_answer/1" do
    test "validates the answer" do
      challenge = insert(:challenge, answer: "42", session: build(:session))
      valid_answer_params = string_params_for(:answer, answer: "42", challenge_id: challenge.id)

      invalid_answer_params =
        string_params_for(:answer, answer: "invalid", challenge_id: challenge.id)

      {:ok, valid_created_answer} = Competitions.validate_and_create_answer(valid_answer_params)
      {:ok, invalid_created_answer} = Competitions.validate_and_create_answer(invalid_answer_params)

      assert valid_created_answer.is_valid == true
      assert invalid_created_answer.is_valid == false
    end

    test "returns the created answer given valid params" do
      challenge = insert(:challenge, session: build(:session))
      answer_params = string_params_for(:answer, challenge_id: challenge.id)

      assert {:ok, %Answer{} = _} = Competitions.validate_and_create_answer(answer_params)
    end

    test "returns error changeset given invalid data" do
      challenge = insert(:challenge, session: build(:session))
      invalid_attrs = %{"username" => "", "answer" => "", "challenge_id" => challenge.id}

      assert {:error, %Ecto.Changeset{}} = Competitions.validate_and_create_answer(invalid_attrs)
    end

    test "returns error :invalid_challenge given an invalid challenge" do
      invalid_attrs = %{"answer" => "42", "challenge_id" => Faker.UUID.v4()}

      assert {:error, :invalid_challenge} = Competitions.validate_and_create_answer(invalid_attrs)
    end
  end

  describe "create_challenge/1" do
    test "creates a challenge given valid data" do
      session = insert(:session)
      valid_attrs = params_for(:challenge, name: "Test challenge", session_id: session.id)

      assert {:ok, %Challenge{} = challenge} = Competitions.create_challenge(valid_attrs)
      assert challenge.name == "Test challenge"
    end

    test "returns error changeset given invalid data" do
      invalid_attrs = %{name: ""}

      assert {:error, %Ecto.Changeset{}} = Competitions.create_challenge(invalid_attrs)
    end
  end

  describe "create_session/1" do
    test "creates a session given valid data" do
      valid_attrs = %{name: "Test session"}

      assert {:ok, %Session{} = session} = Competitions.create_session(valid_attrs)
      assert session.name == "Test session"
    end

    test "returns error changeset given invalid data" do
      invalid_attrs = %{name: ""}

      assert {:error, %Ecto.Changeset{}} = Competitions.create_session(invalid_attrs)
    end
  end

  describe "update_challenge/2" do
    test "updates the challenge given valid data " do
      session = insert(:session)
      challenge = insert(:challenge, name: "Test challenge", session_id: session.id)
      valid_attrs = %{name: "Updated challenge session"}

      assert {:ok, %Challenge{} = challenge} = Competitions.update_challenge(challenge, valid_attrs)
      assert challenge.name == "Updated challenge session"
    end

    test "returns error changeset given invalid data" do
      session = insert(:session)
      challenge = insert(:challenge, session_id: session.id)
      invalid_attrs = %{name: ""}

      assert {:error, %Ecto.Changeset{}} = Competitions.update_challenge(challenge, invalid_attrs)
    end
  end

  describe "update_session/2" do
    test "updates the session given valid data " do
      session = insert(:session, name: "Test session")
      valid_attrs = %{name: "Updated test session"}

      assert {:ok, %Session{} = session} = Competitions.update_session(session, valid_attrs)
      assert session.name == "Updated test session"
    end

    test "returns error changeset given invalid data" do
      session = insert(:session)
      invalid_attrs = %{name: ""}

      assert {:error, %Ecto.Changeset{}} = Competitions.update_session(session, invalid_attrs)
    end
  end

  describe "delete_challenge/1" do
    test "deletes the challenge" do
      challenge = insert(:challenge)

      assert {:ok, %Challenge{}} = Competitions.delete_challenge(challenge)
    end
  end

  describe "delete_session/1" do
    test "deletes the session" do
      session = insert(:session)

      assert {:ok, %Session{}} = Competitions.delete_session(session)
    end
  end

  describe "change_challenge/1" do
    test "returns a challenge changeset" do
      challenge = insert(:challenge)

      assert %Ecto.Changeset{} = Competitions.change_challenge(challenge)
    end
  end

  describe "change_session/1" do
    test "returns a session changeset" do
      session = insert(:session)

      assert %Ecto.Changeset{} = Competitions.change_session(session)
    end
  end

  describe "mark_session_as_started/1" do
    test "updates the session started_at" do
      session = insert(:session, started_at: nil)

      assert {:ok, %Session{} = session} = Competitions.mark_session_as_started(session)
      refute session.started_at == nil
    end
  end

  describe "mark_session_as_completed/1" do
    test "updates the session completed_at" do
      session = insert(:session, completed_at: nil)

      assert {:ok, %Session{} = session} = Competitions.mark_session_as_completed(session)
      refute session.completed_at == nil
    end
  end

  describe "reset_session/1" do
    test "resets the session started_at and completed_at" do
      session =
        insert(:session,
          started_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
          completed_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
        )

      assert {:ok, %Session{} = session} = Competitions.reset_session(session)
      assert session.started_at == nil
      assert session.completed_at == nil
    end
  end
end
