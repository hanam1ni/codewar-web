defmodule CodewarWeb.Admin.ChallengeView do
  use CodewarWeb, :view

  def to_markdown(nil), do: content_tag(:p, gettext("No content"))
  def to_markdown(content), do: Earmark.as_html!(content)
end
