# This code is heavily influenced by the lecture slides for Photo_blog
# if not copy and pasted snippets
defmodule Webdevhw07.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, null: false
      add :profile_photo, :string

      timestamps()
    end

  end
end
