defmodule Webdevhw07.InvitesTest do
  use Webdevhw07.DataCase

  alias Webdevhw07.Invites

  describe "invites" do
    alias Webdevhw07.Invites.Invite

    @valid_attrs %{accept: true, url: "some url", user_email: "some user_email"}
    @update_attrs %{accept: false, url: "some updated url", user_email: "some updated user_email"}
    @invalid_attrs %{accept: nil, url: nil, user_email: nil}

    def invite_fixture(attrs \\ %{}) do
      {:ok, invite} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Invites.create_invite()

      invite
    end

    test "list_invites/0 returns all invites" do
      invite = invite_fixture()
      assert Invites.list_invites() == [invite]
    end

    test "get_invite!/1 returns the invite with given id" do
      invite = invite_fixture()
      assert Invites.get_invite!(invite.id) == invite
    end

    test "create_invite/1 with valid data creates a invite" do
      assert {:ok, %Invite{} = invite} = Invites.create_invite(@valid_attrs)
      assert invite.accept == true
      assert invite.url == "some url"
      assert invite.user_email == "some user_email"
    end

    test "create_invite/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Invites.create_invite(@invalid_attrs)
    end

    test "update_invite/2 with valid data updates the invite" do
      invite = invite_fixture()
      assert {:ok, %Invite{} = invite} = Invites.update_invite(invite, @update_attrs)
      assert invite.accept == false
      assert invite.url == "some updated url"
      assert invite.user_email == "some updated user_email"
    end

    test "update_invite/2 with invalid data returns error changeset" do
      invite = invite_fixture()
      assert {:error, %Ecto.Changeset{}} = Invites.update_invite(invite, @invalid_attrs)
      assert invite == Invites.get_invite!(invite.id)
    end

    test "delete_invite/1 deletes the invite" do
      invite = invite_fixture()
      assert {:ok, %Invite{}} = Invites.delete_invite(invite)
      assert_raise Ecto.NoResultsError, fn -> Invites.get_invite!(invite.id) end
    end

    test "change_invite/1 returns a invite changeset" do
      invite = invite_fixture()
      assert %Ecto.Changeset{} = Invites.change_invite(invite)
    end
  end
end