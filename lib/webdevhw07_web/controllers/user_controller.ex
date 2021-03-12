# This code is heavily influenced by the lecture slides for Photo_blog
# if not copy and pasted snippets
defmodule Webdevhw07Web.UserController do
  use Webdevhw07Web, :controller

  alias Webdevhw07.Users
  alias Webdevhw07.Users.User
  alias Webdevhw07.Photos

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    user = Users.get_user_by_email(user_params["email"])

    if user do
      conn
      |> put_flash(:error, "This Email Already Exists for a User")
      |> redirect(to: Routes.user_path(conn, :index))
    end

    up = user_params["profile_photo"]

    if up do
      {:ok, hash} = Photos.save_photo(up.filename, up.path)

      user_params =
        user_params
        |> Map.put("profile_photo", hash)

      case Users.create_user(user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: Routes.user_path(conn, :show, user))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
      case Users.create_user(user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: Routes.user_path(conn, :show, user))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    up = user_params["profile_photo"]
    old_photo = user.profile_photo

    user_params =
      if up do
        # FIXME: Remove old image
        if old_photo do
          Photos.delete_photo(old_photo)
        end

        {:ok, hash} = Photos.save_photo(up.filename, up.path)
        Map.put(user_params, "profile_photo", hash)
      else
        user_params
      end

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    up = user["profile_photo"]

    if up do
      Photos.delete_photo(up)
    end

    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end

  # New controller function.
  def profile_photo(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _name, data} = Photos.load_photo(user.profile_photo)

    conn
    |> put_resp_content_type("image/jpeg")
    |> send_resp(200, data)
  end
end
