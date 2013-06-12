class AddIsProfilePicToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :is_profile_pic, :boolean
  end
end
