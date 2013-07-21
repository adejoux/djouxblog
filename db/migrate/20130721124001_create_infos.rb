class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :name
      t.string :permalink
      t.text :content

      t.timestamps
    end
    add_index :infos, :permalink
  end
end
