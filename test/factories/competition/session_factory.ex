defmodule Codewar.Competition.SessionFactory do
  defmacro __using__(_opts) do
    quote do
      alias Codewar.Competition.Schemas.Session

      def session_factory do
        %Session{
          name: Faker.Lorem.sentence(3)
        }
      end
    end
  end
end
