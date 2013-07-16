class AddRenderedBodyToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :rendered_body, :text
  end
end
