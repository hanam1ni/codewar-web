defmodule Codewar.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :username, :string, null: false
      add :answer, :text, null: false
      add :is_valid, :boolean, default: false

      add :challenge_id, references(:challenges, on_delete: :delete_all)

      timestamps()
    end
  end
end
