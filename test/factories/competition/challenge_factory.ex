defmodule Codewar.Competition.ChallengeFactory do
  defmacro __using__(_opts) do
    quote do
      alias Codewar.Competition.Schemas.Challenge

      def challenge_factory do
        %Challenge{
          name: Faker.Lorem.sentence(3),
          requirement: Faker.Markdown.markdown(),
          hint: Faker.Markdown.ordered_list(),
          answer: Faker.Team.creature(),
          submission_cap: Enum.random(1..4),
          is_hint_enabled: false
        }
      end
    end
  end
end
