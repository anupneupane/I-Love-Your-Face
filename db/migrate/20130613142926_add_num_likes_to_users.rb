class AddNumLikesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :num_likes, :integer, default: 5
  	add_column :users, :last_like_refresh, :date, default: Time.now
  end
end
