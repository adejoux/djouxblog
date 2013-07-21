class AddPermalinkToPage < ActiveRecord::Migration
  def change
    add_column :pages, :permalink, :string
    add_index :pages, :permalink
  end
end
