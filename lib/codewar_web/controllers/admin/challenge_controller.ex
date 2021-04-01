defmodule CodewarWeb.Admin.ChallengeController do
  use CodewarWeb, :controller

  alias Codewar.Competition.Competitions
  alias Codewar.Competition.Schemas.Challenge

  def new(conn, %{"session_id" => session_id}) do
    session = Competitions.get_session(session_id)
    changeset = Competitions.change_challenge(%Challenge{})

    render(conn, "new.html", session: session, changeset: changeset)
  end

  def create(conn, %{"session_id" => session_id, "challenge" => challenge_params}) do
    case Competitions.create_challenge(challenge_params) do
      {:ok, challenge} ->
        conn
        |> put_flash(:info, "Challenge created successfully.")
        |> redirect(to: Routes.challenge_path(conn, :show, challenge))

      {:error, %Ecto.Changeset{} = changeset} ->
        session = Competitions.get_session(session_id)

        render(conn, "new.html", session: session, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    challenge = Competitions.get_challenge(id)
    render(conn, "show.html", challenge: challenge)
  end

  def edit(conn, %{"id" => id}) do
    challenge = Competitions.get_challenge(id)
    changeset = Competitions.change_challenge(challenge)

    render(conn, "edit.html", challenge: challenge, changeset: changeset)
  end

  def update(conn, %{"id" => id, "challenge" => challenge_params}) do
    challenge = Competitions.get_challenge(id)

    case Competitions.update_challenge(challenge, challenge_params) do
      {:ok, challenge} ->
        conn
        |> put_flash(:info, "Challenge updated successfully.")
        |> redirect(to: Routes.challenge_path(conn, :show, challenge))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", challenge: challenge, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    challenge = Competitions.get_challenge(id)
    {:ok, _challenge} = Competitions.delete_challenge(challenge)

    conn
    |> put_flash(:info, "Challenge deleted successfully.")
    |> redirect(to: Routes.session_path(conn, :show, challenge.session_id))
  end
end
