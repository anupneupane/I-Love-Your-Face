class AddShunnings < ActiveRecord::Migration
  def change 
  	create_table :shunnings do |t|
  		t.integer :shunning_user_id
  		t.integer :shunned_user_id

  		t.timestamps
  	end

  	add_index :shunnings, :shunning_user_id
  	add_index :shunnings, :shunned_user_id
  end
end
