defmodule Codewar.Repo.Migrations.AddValidationColumnsToAnswers do
  use Ecto.Migration

  def change do
    alter table(:answers) do
      add :is_rejected, :boolean, default: false
    end
  end
end
