class RenamePostToPage < ActiveRecord::Migration
  def change
    rename_table :posts, :pages
  end
end
