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
     |> assign(winner_list: [])
     |> assign(:show_hint, false)
     |> assign(changeset: empty_answer_changeset())
     |> maybe_fetch_competition_data()}
  end

  @impl true
  def handle_event("submit_answer", %{"answer" => answer_params}, socket) do
    case Competitions.validate_and_create_answer(answer_params) do
      {:ok, answer} ->
        if answer.is_valid do
          CompetitionChannel.notify_subscribers(:announce_winner, answer.challenge_id)

          handle_user_feedback(socket, answer, :success, "Well done! Challenge solved.")
        else
          handle_user_feedback(socket, answer, :error, "Try again. The answer is invalid.")
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}

      {:error, :submission_cap_reached} ->
        handle_user_feedback(
          socket,
          :error,
          "Too late. No new answers are accepted for this challenge."
        )

      {:error, :invalid_challenge} ->
        handle_user_feedback(socket, :error, "This challenge does not exist.")
    end
  end

  @impl true
  def handle_info({:start_session, session}, socket) do
    {:noreply, assign(socket, :current_session, session)}
  end

  @impl true
  def handle_info({:stop_session, _}, socket) do
    socket =
      socket
      |> assign(:current_session, nil)
      |> assign(:current_challenge, nil)
      |> assign(:show_hint, false)
      |> assign(winner_list: [])
      |> assign(changeset: empty_answer_changeset())
      |> clear_flash(:error)
      |> clear_flash(:success)

    {:noreply, socket}
  end

  @impl true
  @doc """
  Upon starting a challenge the winner list is fetched in the case of a completed challenge is started again.
  """
  def handle_info({:start_challenge, challenge}, socket) do
    socket =
      socket
      |> assign(:current_challenge, challenge)
      |> assign(:show_hint, false)
      |> assign(winner_list: fetch_challenge_winner_list(challenge.id))
      |> assign(changeset: empty_answer_changeset())
      |> clear_flash(:error)
      |> clear_flash(:success)

    {:noreply, assign(socket, :current_challenge, challenge)}
  end

  @impl true
  def handle_info({:stop_challenge, _}, socket) do
    socket =
      socket
      |> assign(:current_challenge, nil)
      |> assign(:show_hint, false)
      |> assign(winner_list: [])
      |> assign(changeset: empty_answer_changeset())
      |> clear_flash(:error)
      |> clear_flash(:success)

    {:noreply, socket}
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
  def handle_info({:rejected_answer, challenge}, socket) do
    {:noreply, assign(socket, :winner_list, fetch_challenge_winner_list(challenge.id))}
  end

  @impl true
  def handle_info({:announce_winner, challenge_id}, socket) do
    socket =
      socket
      |> assign(:winner_list, fetch_challenge_winner_list(challenge_id))
      |> push_event("start:confetti", %{})

    {:noreply, socket}
  end

  @impl true
  def handle_info(_, socket), do: {:noreply, socket}

  def to_markdown(content), do: Earmark.as_html!(content)

  def format_winner_name(winner_list, index, submission_cap) do
    winner_name = Enum.at(winner_list, index - 1)

    if is_nil(winner_name) do
      format_winner_placeholder(index, submission_cap)
    else
      winner_name
    end
  end

  defp format_winner_placeholder(_index, submission_cap) when submission_cap == 1, do: "Winner"

  defp format_winner_placeholder(index, _submission_cap), do: "Winner ##{index}"

  defp maybe_fetch_competition_data(%{connected?: true} = socket) do
    active_session = get_active_session()
    active_challenge = get_active_challenge()

    socket
    |> assign(:current_session, active_session)
    |> assign(:current_challenge, active_challenge)
    |> assign(:winner_list, maybe_fetch_challenge_winner_list(active_challenge))
  end

  defp maybe_fetch_competition_data(socket), do: socket

  defp get_active_session, do: Competitions.get_active_session()

  defp get_active_challenge, do: Competitions.get_active_challenge()

  defp maybe_fetch_challenge_winner_list(challenge) when is_nil(challenge), do: []

  defp maybe_fetch_challenge_winner_list(challenge), do: fetch_challenge_winner_list(challenge.id)

  defp fetch_challenge_winner_list(challenge_id) do
    challenge_id
    |> Competitions.list_valid_challenge_answers()
    |> Enum.map(fn answer -> answer.username end)
  end

  defp empty_answer_changeset do
    Answer.changeset(%Answer{}, %{})
  end

  defp handle_user_feedback(socket, type, message) do
    {:noreply,
     socket
     |> clear_flash(:error)
     |> clear_flash(:success)
     |> put_flash(type, message)}
  end

  defp handle_user_feedback(socket, answer, type, message) do
    {:noreply,
     socket
     |> clear_flash(:error)
     |> clear_flash(:success)
     |> put_flash(type, message)
     |> assign(changeset: Answer.changeset(answer, %{}))}
  end
end
