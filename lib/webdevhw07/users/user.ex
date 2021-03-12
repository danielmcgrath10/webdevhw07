defmodule Webdevhw07.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, null: false
    field :name, :string, null: false
    has_many :posts, Webdevhw07.Activities.Activity
    has_many :comments, Webdevhw07.Comments.Comment
    has_many :invites, Webdevhw07.Invites.Invite

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
