class ChangePage < ActiveRecord::Migration
  def up
    remove_column :pages, :published, :boolean
    add_column :pages, :publish_at, :datetime
    Page.all.each do |page|
      page.publish_at=Time.now
      page.save
   end
  end

  def down
    add_column :pages, :published, :boolean
    remove_column :pages, :publish_at, :datetime
  end



end
