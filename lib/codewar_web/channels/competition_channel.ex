defmodule CodewarWeb.Channels.CompetitionChannel do
  @moduledoc """
  Channel for real-time messaging during a competition.
  """

  @topic inspect(__MODULE__)

  @spec subscribe() :: :ok | {:error, term()}
  def subscribe do
    Phoenix.PubSub.subscribe(Codewar.PubSub, @topic)
  end

  @spec notify_subscribers(term(), atom()) :: term()
  def notify_subscribers(message, event) do
    Phoenix.PubSub.broadcast(Codewar.PubSub, @topic, {message, event})

    message
  end
end
