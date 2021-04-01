# coveralls-ignore-start
defmodule CodewarWeb.Home.IndexLive do
  use CodewarWeb, :live_view

  alias Codewar.Competition.Competitions
  alias Codewar.Competition.Schemas.Challenge
  alias Codewar.Competition.Schemas.Session

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(current_session: %{})
     |> assign(current_challenge: %{})
     |> maybe_fetch_competition_data()}
  end

  defp maybe_fetch_competition_data(%{connected?: true} = socket) do
    socket
    |> assign(:current_session, get_active_session())
    |> assign(:current_session, get_active_challenge())
  end

  defp maybe_fetch_competition_data(socket), do: socket

  defp get_active_session do
    case Competitions.get_active_session() do
      nil -> %{}
      %Session{} = session -> session
    end
  end

  defp get_active_challenge do
    case Competitions.get_active_challenge() do
      nil -> %{}
      %Challenge{} = challenge -> challenge
    end
  end
end
