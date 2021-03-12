defmodule Webdevhw07Web.ActivityController do
  use Webdevhw07Web, :controller

  alias Webdevhw07.Activities
  alias Webdevhw07.Activities.Activity
  alias Webdevhw07Web.Plugs.RequireUser
  plug RequireUser when action in [:new, :edit, :create, :update, :delete, :show]
  plug :fetch_activity when action in [:show, :edit, :update, :delete]
  plug :require_owner when action in [:edit, :update, :delete]

  def require_owner(conn, _args) do
    user = conn.assigns[:current_user]
    activity = conn.assigns[:activity]

    if user.id == activity.user_id do
      conn
    else
      conn
      |> put_flash(:error, "This is not your activity to edit")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    activities = Activities.list_activities()
    render(conn, "index.html", activities: activities)
  end

  def fetch_activity(conn, _args) do
    id=conn.params["id"]
    activity = Activities.get_activity!(id)
    assign(conn, :activity, activity)
  end

  def new(conn, _params) do
    changeset = Activities.change_activity(%Activity{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"activity" => activity_params}) do
    activity_params = activity_params
    |> Map.put("user_id", conn.assigns[:current_user].id)
    case Activities.create_activity(activity_params) do
      {:ok, activity} ->
        conn
        |> put_flash(:info, "Activity created successfully.")
        |> redirect(to: Routes.activity_path(conn, :show, activity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => _id}) do
    activity = conn.assigns[:activity]
    |> Activities.load_comments()
    |> Activities.load_invites()

    inv = %Webdevhw07.Invites.Invite{
      activity_id: activity.id,
      user_id: creator_id(conn)
    }
    comm = %Webdevhw07.Comments.Comment{
      activity_id: activity.id,
      user_id: current_user_id(conn)
    }
    new_comment = Webdevhw07.Comments.change_comment(comm)
    new_invite = Webdevhw07.Invites.change_invite(inv)
    render(conn, "show.html", activity: activity, new_comment: new_comment, new_invite: new_invite)
  end

  def edit(conn, %{"id" => _id}) do
    activity = conn.assigns[:activity]
    changeset = Activities.change_activity(activity)
    render(conn, "edit.html", activity: activity, changeset: changeset)
  end

  def update(conn, %{"id" => _id, "activity" => activity_params}) do
    activity = conn.assigns[:activity]

    case Activities.update_activity(activity, activity_params) do
      {:ok, activity} ->
        conn
        |> put_flash(:info, "Activity updated successfully.")
        |> redirect(to: Routes.activity_path(conn, :show, activity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", activity: activity, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => _id}) do
    activity = conn.assigns[:activity]
    {:ok, _activity} = Activities.delete_activity(activity)

    conn
    |> put_flash(:info, "Activity deleted successfully.")
    |> redirect(to: Routes.activity_path(conn, :index))
  end
end
