defmodule CodewarWeb.HomePage.ViewHomePageTest do
  use CodewarWeb.FeatureCase

  feature "view home page", %{session: session} do
    visit(session, Routes.page_path(CodewarWeb.Endpoint, :index))

    assert_has(session, Query.text("Welcome to Phoenix!"))
  end
end
