class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.string :path
      t.text :descrption

      t.timestamps
    end
  end
end
