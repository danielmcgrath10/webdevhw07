defmodule Webdevhw07.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :accept, :boolean, default: false
    field :url, :string
    field :user_email, :string, null: false
    belongs_to :activity, Webdevhw07.Activities.Activity
    belongs_to :user, Webdevhw07.Users.User

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:user_email, :url, :accept, :activity_id, :user_id])
    |> validate_required([:user_email, :url, :accept, :activity_id, :user_id])
  end
end
