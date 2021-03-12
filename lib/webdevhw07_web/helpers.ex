# This code is heavily influenced by the lecture slides for Photo_blog
# if not copy and pasted snippets
defmodule Webdevhw07Web.Helpers do
  def have_current_user?(conn) do
    conn.assigns[:current_user] != nil
  end

  def current_user_id?(conn, user_id) do
    user = conn.assigns[:current_user]
    user && user.id == user_id
  end

  def current_user_id(conn) do
    user = conn.assigns[:current_user]
    user && user.id
  end

  def creator_id(conn) do
    user = conn.assigns[:current_user]
    activity = conn.assigns[:activity]
    user && activity.user_id
  end

  def in_invites?(conn, invites) do
    user = conn.assigns[:current_user]

    if user do
      match =
        Enum.find(invites, fn invite ->
          invite.user_email == user.email
        end)

      if match do
        true
      else
        false
      end
    else
      false
    end
  end
end
