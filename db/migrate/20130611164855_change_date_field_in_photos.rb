class ChangeDateFieldInPhotos < ActiveRecord::Migration
  def change
  	remove_column :photos, :date_taken
  	add_column :photos, :photo_age, :integer
  end
end
