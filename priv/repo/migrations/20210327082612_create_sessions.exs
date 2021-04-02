defmodule Codewar.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :name, :string, null: false
      add :started_at, :naive_datetime
      add :completed_at, :naive_datetime

      timestamps()
    end
  end
end
