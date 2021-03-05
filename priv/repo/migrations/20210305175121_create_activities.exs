defmodule Webdevhw07.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :user_id, references(:users), null: false
      add :body, :text, null: false 

      timestamps()
    end

  end
end
