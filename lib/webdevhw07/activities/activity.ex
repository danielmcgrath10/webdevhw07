defmodule Webdevhw07.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :name, :string, null: false
    field :date, :string, null: false
    field :body, :string

    belongs_to :user, Webdevhw07.Users.User

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:name, :date, :body, :user_id])
    |> validate_required([:name, :date, :body, :user_id])
  end
end
