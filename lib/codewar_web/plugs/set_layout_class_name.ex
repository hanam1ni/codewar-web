defmodule CodewarWeb.Plugs.SetLayoutClassName do
  import Plug.Conn

  def init(opts), do: opts

  @doc """
  Assign :layout_class_name given a parameter
  """
  def call(conn, {:class_name, class_name} = _params) do
    assign(conn, :layout_class_name, class_name)
  end
end
