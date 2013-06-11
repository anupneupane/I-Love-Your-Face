class TypesTable < ActiveRecord::Migration
  def change
  	create_table :types do |t|
  		t.integer :user_id
  	end

  	add_index :types, :user_id
  end
end
