class RenameAlbumToMedia < ActiveRecord::Migration
  def up
    rename_table :albums, :images
  end

  def down
    rename_table :images, :albums
  end
end
