defmodule CodewarWeb.Admin.SessionView do
  use CodewarWeb, :view

  def completed?(resource) when is_nil(resource.completed_at), do: false
  def completed?(_), do: true

  def active?(resource) when is_nil(resource.started_at), do: false
  def active?(_), do: true
end
