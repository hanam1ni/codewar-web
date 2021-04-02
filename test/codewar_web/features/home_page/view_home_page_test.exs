defmodule CodewarWeb.HomePage.ViewHomePageTest do
  use CodewarWeb.FeatureCase

  feature "view home page given no competition is active", %{session: session} do
    visit(session, Routes.home_path(CodewarWeb.Endpoint, :index))

    assert_has(session, Query.css(".blank-state"))
    assert_has(session, Query.text("No active competition. Check back later."))
  end
end
