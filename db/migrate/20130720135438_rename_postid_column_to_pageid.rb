class RenamePostidColumnToPageid < ActiveRecord::Migration
  def change
    rename_column :comments, :post_id, :page_id
  end
end
