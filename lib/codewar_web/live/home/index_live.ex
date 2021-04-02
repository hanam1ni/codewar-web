# coveralls-ignore-start
defmodule CodewarWeb.Home.IndexLive do
  use CodewarWeb, :live_view

  import CodewarWeb.ErrorHelpers
  alias Codewar.Competition.Competitions
  alias Codewar.Competition.Schemas.Answer
  alias CodewarWeb.Channels.CompetitionChannel

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: CompetitionChannel.subscribe()

    {:ok,
     socket
     |> assign(current_session: nil)
     |> assign(current_challenge: nil)
     |> assign(:show_hint, false)
     |> assign(changeset: empty_answer_changeset())
     |> maybe_fetch_competition_data()}
  end

  @impl true
  def handle_event("submit_answer", %{"answer" => answer_params}, socket) do
    case Competitions.validate_and_create_answer(answer_params) do
      {:ok, answer} ->
        if answer.is_valid do
          CompetitionChannel.notify_subscribers(
            :announce_winner,
            "Well done! " <> answer.username <> " solved the challenge 👏"
          )

          handle_user_feedback(socket, answer, :info, "Well done! Challenge solved.")
        else
          handle_user_feedback(socket, answer, :error, "Try again. The answer is invalid.")
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}

      {:error, :invalid_challenge} ->
        {:noreply, put_flash(socket, :error, "This challenge does not exist")}
    end
  end

  @impl true
  def handle_info({:start_session, session}, socket) do
    {:noreply, assign(socket, :current_session, session)}
  end

  @impl true
  def handle_info({:stop_session, _}, socket) do
    {:noreply, assign(socket, :current_session, nil)}
  end

  @impl true
  def handle_info({:start_challenge, challenge}, socket) do
    socket =
      socket
      |> assign(:current_challenge, challenge)
      |> assign(:show_hint, false)
      |> clear_flash(:error)
      |> clear_flash(:info)
      |> clear_flash(:success)
      |> assign(changeset: empty_answer_changeset())

    {:noreply, socket}
  end

  @impl true
  def handle_info({:stop_challenge, _}, socket) do
    {:noreply, assign(socket, :current_challenge, nil)}
  end

  @impl true
  def handle_info({:show_hint, challenge}, socket) do
    socket =
      socket
      |> assign(:current_challenge, challenge)
      |> assign(:show_hint, true)

    {:noreply, socket}
  end

  @impl true
  def handle_info({:announce_winner, message}, socket) do
    {:noreply, put_flash(socket, :success, message)}
  end

  @impl true
  def handle_info(_, socket), do: {:noreply, socket}

  def to_markdown(content), do: Earmark.as_html!(content)

  defp maybe_fetch_competition_data(%{connected?: true} = socket) do
    socket
    |> assign(:current_session, get_active_session())
    |> assign(:current_challenge, get_active_challenge())
  end

  defp maybe_fetch_competition_data(socket), do: socket

  defp get_active_session do
    Competitions.get_active_session()
  end

  defp get_active_challenge do
    Competitions.get_active_challenge()
  end

  defp empty_answer_changeset do
    Competitions.change_answer(%Answer{})
  end

  defp handle_user_feedback(socket, answer, type, message) do
    {:noreply,
     socket
     |> clear_flash(:error)
     |> clear_flash(:info)
     |> put_flash(type, message)
     |> assign(changeset: Competitions.change_answer(answer))}
  end
end
