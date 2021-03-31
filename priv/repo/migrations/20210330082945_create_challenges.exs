defmodule Codewar.Repo.Migrations.CreateChallenges do
  use Ecto.Migration

  def change do
    create table(:challenges, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :name, :string, null: false
      add :requirement, :text, null: false
      add :hint, :text
      add :answer, :string, null: false
      add :submission_cap, :integer, default: 1
      add :started_at, :naive_datetime
      add :completed_at, :naive_datetime

      add :session_id, references(:sessions, on_delete: :delete_all)

      timestamps()
    end
  end
end
