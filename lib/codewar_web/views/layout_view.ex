defmodule CodewarWeb.LayoutView do
  use CodewarWeb, :view

  alias Plug.Conn

  @spec page_class_name(%Conn{}) :: String.t()
  def layout_class_name(%{assigns: %{layout_class_name: class_name}}) do
    "layout-#{class_name}"
  end

  def layout_class_name(_) do
    "layout-application"
  end

  @spec page_class_name(%Conn{}) :: String.t()
  def page_class_name(%{assigns: %{live_action: action_name, live_module: module_name}}) do
    "#{live_module_class_name(module_name)} #{Atom.to_string(action_name)}"
  end

  @spec page_class_name(%Conn{}) :: String.t()
  def page_class_name(conn) do
    "#{module_class_name(conn)} #{action_name(conn)}"
  end

  defp live_module_class_name(module_name) do
    module_name
    |> Phoenix.Naming.resource_name()
    |> String.replace("_", "-")
  end

  defp module_class_name(conn) do
    conn
    |> controller_module()
    |> Phoenix.Naming.resource_name("Controller")
    |> String.replace("_", "-")
  end
end
