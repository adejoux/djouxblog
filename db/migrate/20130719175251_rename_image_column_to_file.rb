class RenameImageColumnToFile < ActiveRecord::Migration
  def change
    rename_column :images, :image, :file
  end
end
