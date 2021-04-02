defmodule Codewar.Competition.AnswerFactory do
  defmacro __using__(_opts) do
    quote do
      alias Codewar.Competition.Schemas.Answer

      def answer_factory do
        %Answer{
          username: Faker.Team.creature(),
          answer: Faker.Team.creature(),
          is_valid: false
        }
      end
    end
  end
end
