defmodule Webdevhw07.Inject do
  alias Webdevhw07.Photos
  def photo(name) do
    photos = Application.app_dir(:webdevhw07, "priv/photos")
    path = Path.join(photos, name)
    {:ok, hash} = Photos.save_photo(name, path)
    hash
  end
end
