class AddIsMatchToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :is_match, :boolean, default: false
  end
end
