class AddIsUserToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :is_user, :boolean
  end
end
