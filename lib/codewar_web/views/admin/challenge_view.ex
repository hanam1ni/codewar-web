defmodule CodewarWeb.Admin.ChallengeView do
  use CodewarWeb, :view

  def to_markdown(nil), do: content_tag(:p, gettext("No content"))
  def to_markdown(content), do: Earmark.as_html!(content)

  def to_validity_status(answer) when answer.is_rejected,
    do: content_tag(:span, gettext("Rejected"), class: "badge badge--danger")

  def to_validity_status(answer) when answer.is_valid,
    do: content_tag(:span, gettext("Valid"), class: "badge badge--success")

  def to_validity_status(_answer),
    do: content_tag(:span, gettext("Invalid"), class: "badge badge--warning")
end
