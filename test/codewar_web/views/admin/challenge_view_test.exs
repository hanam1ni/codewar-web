defmodule CodewarWeb.Admin.ChallengeViewTest do
  use CodewarWeb.ConnCase, async: true

  import Phoenix.HTML.Tag

  alias CodewarWeb.Admin.ChallengeView

  describe "to_markdown/1" do
    test "returns placeholder content given nil content" do
      assert ChallengeView.to_markdown(nil) == content_tag(:p, "No content")
    end

    test "returns HTML content given markdown content" do
      markdown_content = "# Test tile"

      assert ChallengeView.to_markdown(markdown_content) == "<h1>\nTest tile</h1>\n"
    end
  end

  describe "to_validity_status/1" do
    test "returns a valid status badge given a valid answer" do
      challenge = insert(:challenge, session: build(:session))
      answer = insert(:answer, is_valid: true, challenge_id: challenge.id)

      assert ChallengeView.to_validity_status(answer) ==
               content_tag(:span, "Valid", class: "badge badge--success")
    end

    test "returns an invalid status badge given an invalid answer" do
      challenge = insert(:challenge, session: build(:session))
      answer = insert(:answer, is_valid: false, challenge_id: challenge.id)

      assert ChallengeView.to_validity_status(answer) ==
               content_tag(:span, "Invalid", class: "badge badge--warning")
    end

    test "returns a rejected status badge given a rejected answer" do
      challenge = insert(:challenge, session: build(:session))
      answer = insert(:answer, is_rejected: true, challenge_id: challenge.id)

      assert ChallengeView.to_validity_status(answer) ==
               content_tag(:span, "Rejected", class: "badge badge--danger")
    end
  end
end
