defmodule Webdevhw07.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :body, :string

    belongs_to :user, Webdevhw07.Users.User

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
