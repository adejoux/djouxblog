class RenameArticlesToPosts < ActiveRecord::Migration
  def up
    rename_table :articles, :posts
  end

  def down
    rename_table :posts, :articles
  end
end
