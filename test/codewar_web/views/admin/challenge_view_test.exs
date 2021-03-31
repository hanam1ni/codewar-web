defmodule CodewarWeb.Admin.ChallengeViewTest do
  use CodewarWeb.ConnCase, async: true

  import Phoenix.HTML.Tag

  alias CodewarWeb.Admin.ChallengeView

  describe "to_markdown/1" do
    test "returns placeholder content given nil content" do
      assert ChallengeView.to_markdown(nil) == content_tag(:p, "No hint")
    end

    test "returns HTML content given markown content" do
      markdown_content = "# Test tile"

      assert ChallengeView.to_markdown(markdown_content) == "<h1>\nTest tile</h1>\n"
    end
  end
end
