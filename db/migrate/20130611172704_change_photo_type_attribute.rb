class ChangePhotoTypeAttribute < ActiveRecord::Migration
  def change
  	remove_column :photos, :type
  	add_column :photos, :photo_type, :string
  end
end
