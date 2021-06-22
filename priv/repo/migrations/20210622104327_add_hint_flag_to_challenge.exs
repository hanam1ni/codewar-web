defmodule Codewar.Repo.Migrations.AddHintFlagToChallenge do
  use Ecto.Migration

  def change do
    alter table(:challenges) do
      add :is_hint_enabled, :boolean, default: false
    end
  end
end
