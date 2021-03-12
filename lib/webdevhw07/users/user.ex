defmodule Webdevhw07.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, null: false
    field :name, :string, null: false
    field :profile_photo, :string

    has_many :posts, Webdevhw07.Activities.Activity
    has_many :comments, Webdevhw07.Comments.Comment
    has_many :invites, Webdevhw07.Invites.Invite

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :profile_photo])
    |> validate_required([:name, :email, :profile_photo])
  end
end
