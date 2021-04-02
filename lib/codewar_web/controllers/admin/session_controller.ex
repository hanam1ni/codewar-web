defmodule CodewarWeb.Admin.SessionController do
  use CodewarWeb, :controller

  alias Codewar.Competition.Competitions
  alias Codewar.Competition.Schemas.Session
  alias CodewarWeb.Channels.CompetitionChannel

  def new(conn, _params) do
    changeset = Competitions.change_session(%Session{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"session" => session_params}) do
    case Competitions.create_session(session_params) do
      {:ok, session} ->
        conn
        |> put_flash(:info, "Session created successfully.")
        |> redirect(to: Routes.session_path(conn, :show, session))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    session = Competitions.get_session(id)
    render(conn, "show.html", session: session)
  end

  def edit(conn, %{"id" => id}) do
    session = Competitions.get_session(id)
    changeset = Competitions.change_session(session)

    render(conn, "edit.html", session: session, changeset: changeset)
  end

  def update(conn, %{"id" => id, "session" => session_params}) do
    session = Competitions.get_session(id)

    case Competitions.update_session(session, session_params) do
      {:ok, session} ->
        conn
        |> put_flash(:info, "Session updated successfully.")
        |> redirect(to: Routes.session_path(conn, :show, session))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", session: session, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    session = Competitions.get_session(id)
    {:ok, _session} = Competitions.delete_session(session)

    conn
    |> put_flash(:info, "Session deleted successfully.")
    |> redirect(to: Routes.dashboard_path(conn, :index))
  end

  def start(conn, %{"session_id" => session_id}) do
    session = Competitions.get_session(session_id)

    case Competitions.mark_session_as_started(session) do
      {:ok, session} ->
        CompetitionChannel.notify_subscribers(:start_session, session)

        conn
        |> put_flash(:info, "Session started successfully.")
        |> redirect(to: Routes.session_path(conn, :show, session))

      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_flash(:error, "The session cannot be started.")
        |> redirect(to: Routes.session_path(conn, :show, session))
    end
  end

  def stop(conn, %{"session_id" => session_id}) do
    session = Competitions.get_session(session_id)

    case Competitions.mark_session_as_completed(session) do
      {:ok, session} ->
        CompetitionChannel.notify_subscribers(:stop_session, session)

        conn
        |> put_flash(:info, "Session stopped successfully.")
        |> redirect(to: Routes.session_path(conn, :show, session))

      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_flash(:error, "The session cannot be stopped.")
        |> redirect(to: Routes.session_path(conn, :show, session))
    end
  end

  def reset(conn, %{"session_id" => session_id}) do
    session = Competitions.get_session(session_id)

    case Competitions.reset_session(session) do
      {:ok, session} ->
        conn
        |> put_flash(:info, "Session reset successfully.")
        |> redirect(to: Routes.session_path(conn, :show, session))

      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_flash(:error, "The session cannot be reset.")
        |> redirect(to: Routes.session_path(conn, :show, session))
    end
  end
end
