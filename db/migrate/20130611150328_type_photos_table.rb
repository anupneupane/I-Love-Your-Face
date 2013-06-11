class TypePhotosTable < ActiveRecord::Migration
  def change
  	create_table :type_photos do |t|
  		t.integer :type_id
  		t.integer :photo_id
  	end

  	add_index :type_photos, :type_id
  	add_index :type_photos, :photo_id
  end
end
