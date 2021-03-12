defmodule Webdevhw07.Repo.Migrations.CreateInvites do
  use Ecto.Migration

  def change do
    create table(:invites) do
      add :user_email, :text, null: false
      add :url, :text, default: "https://helloworld.com"
      add :accept, :boolean, default: false
      add :activity_id, references(:activities, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:invites, [:activity_id])
  end
end
