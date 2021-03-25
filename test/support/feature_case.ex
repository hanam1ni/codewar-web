defmodule CodewarWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.Feature

      import Codewar.Factory

      alias CodewarWeb.Router.Helpers, as: Routes
    end
  end
end
