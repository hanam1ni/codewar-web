# coveralls-ignore-start
defmodule CodewarWeb.Home.IndexLive do
  use CodewarWeb, :live_view

  import CodewarWeb.ErrorHelpers

  alias Codewar.Competition.Competitions
  alias Codewar.Competition.Schemas.Answer

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(current_session: nil)
     |> assign(current_challenge: nil)
     |> assign(changeset: Competitions.change_answer(%Answer{}))
     |> maybe_fetch_competition_data()}
  end

  @impl true
  def handle_event("submit_answer", %{"answer" => answer_params}, socket) do
    case Competitions.validate_and_create_answer(answer_params) do
      {:ok, answer} ->
        if answer.is_valid do
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

  defp handle_user_feedback(socket, answer, type, message) do
    {:noreply,
     socket
     |> clear_flash(:error)
     |> put_flash(type, message)
     |> assign(changeset: Competitions.change_answer(answer))}
  end
end
