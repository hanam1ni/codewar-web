defmodule Codewar.Competition.AnswerFactory do
  defmacro __using__(_opts) do
    quote do
      alias Codewar.Competition.Schemas.Answer

      def answer_factory do
        %Answer{
          username: Faker.Team.creature(),
          answer: Faker.Team.creature(),
          is_valid: false,
          is_rejected: false
        }
      end

      def valid_answer_factory do
        %Answer{
          username: Faker.Team.creature(),
          answer: Faker.Team.creature(),
          is_valid: true,
          is_rejected: false
        }
      end

      def rejected_answer_factory do
        %Answer{
          username: Faker.Team.creature(),
          answer: Faker.Team.creature(),
          is_valid: true,
          is_rejected: true
        }
      end
    end
  end
end
