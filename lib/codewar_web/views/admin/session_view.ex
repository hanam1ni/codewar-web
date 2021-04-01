defmodule CodewarWeb.Admin.SessionView do
  use CodewarWeb, :view

  def completed?(session) when is_nil(session.completed_at), do: false
  def completed?(_), do: true

  def active?(session) when is_nil(session.started_at), do: false
  def active?(_), do: true
end
