class ModifyPage < ActiveRecord::Migration
  def change
    remove_column :pages, :author
    add_column :pages, :user_id, :integer
  end
end
