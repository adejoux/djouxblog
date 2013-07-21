class AddRenderedBodyToInfo < ActiveRecord::Migration
  def change
    add_column :infos, :rendered_body, :text
  end
end
