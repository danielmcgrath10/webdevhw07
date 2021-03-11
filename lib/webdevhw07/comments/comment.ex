defmodule Webdevhw07.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string, null: false
    belongs_to :activity, Webdevhw07.Activities.Activity
    belongs_to :user, Webdevhw07.Users.User

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :activity_id, :user_id])
    |> validate_required([:body, :activity_id, :user_id])
  end
end
