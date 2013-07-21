class RemoveTables < ActiveRecord::Migration
  def up
    drop_table :infos
    drop_table :mercury_images
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
