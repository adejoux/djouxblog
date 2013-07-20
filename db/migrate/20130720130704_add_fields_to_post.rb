class AddFieldsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :ancestry, :string
    add_index :posts, :ancestry
    add_column :posts, :category, :string
  end
end
