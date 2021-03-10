# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Webdevhw07.Repo.insert!(%Webdevhw07.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Webdevhw07.Repo
alias Webdevhw07.Users.User
alias Webdevhw07.Activities.Activity

alice = Repo.insert!(%User{name: "alice"})
bob = Repo.insert!(%User{name: "bob"})

Repo.insert!(%Activity{user_id: alice.id, name: "Super Bash", date: "", body: "This is a sick message"})
Repo.insert!(%Activity{user_id: bob.id, name: "Secret Stuff", date: "", body: "This is also a sick message"})

# Repo.insert!(%Activity{name: "Super Bash", date: "", body: "This is a sick message"})
# Repo.insert!(%Activity{name: "Secret Stuff", date: "", body: "This is also a sick message"})
