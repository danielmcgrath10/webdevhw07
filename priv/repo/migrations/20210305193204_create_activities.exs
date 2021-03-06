# This code is heavily influenced by the lecture slides for Photo_blog
# if not copy and pasted snippets
defmodule Webdevhw07.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :name, :text, null: false
      add :date, :text, null: false
      add :body, :text, null: false
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end
