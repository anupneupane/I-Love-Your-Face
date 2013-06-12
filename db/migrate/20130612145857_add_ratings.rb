class AddRatings < ActiveRecord::Migration
  def change 
  	create_table :ratings do |t|
  		t.integer :rating_giver_id
  		t.integer :rating_receiver_id
  		t.integer :score

  		t.timestamps
  	end

  	add_index :ratings, :rating_giver_id
  	add_index :ratings, :rating_receiver_id
  end
end
