class AddLikings < ActiveRecord::Migration
  def change 
  	create_table :likings do |t|
  		t.integer :liking_user_id
  		t.integer :liked_user_id

  		t.timestamps
  	end

  	add_index :likings, :liked_user_id
  	add_index :likings, :liking_user_id
  end
end
