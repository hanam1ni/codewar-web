defmodule CodewarWeb.SetLayoutClassNameTest do
  use CodewarWeb.ConnCase
  use Plug.Test

  alias CodewarWeb.Plugs.SetLayoutClassName

  describe "init/1" do
    test "returns given options" do
      assert SetLayoutClassName.init([]) == []
    end
  end

  describe "call/2" do
    test "assigns :layout_class_name given a valid parameter" do
      conn = SetLayoutClassName.call(build_conn(), {:class_name, "admin"})

      assert conn.assigns.layout_class_name == "admin"
    end
  end
end
