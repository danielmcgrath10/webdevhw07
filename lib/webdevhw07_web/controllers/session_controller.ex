defmodule Webdevhw07Web.SessionController do
    use Webdevhw07Web, :controller

    def create(conn, %{"email" => email}) do
        user = Webdevhw07.Users.get_user_by_email(email)
        if user do
            conn
            |> put_session(:user_id, user.id)
            |> put_flash(:info, "Welcome back #{user.name}")
            |> redirect(to: Routes.page_path(conn, :index))
        else
            conn
            |> put_flash(:error, "Login Failed")
            |> redirect(to: Routes.page_path(conn, :index))
        end
    end

    def delete(conn, _params) do
        conn
        |> delete_session(:user_id)
        |> put_flash(:info, "Logged Out")
        |> redirect(to: Routes.page_path(conn, :index))
    end
end
