class AddMatchesJoinTable < ActiveRecord::Migration
  def change
  	create_table :type_matches do |t|
  		t.integer :user_id
  		t.integer :type_id
  	end

  	add_index :type_matches, :user_id
  	add_index :type_matches, :type_id
  end
end
