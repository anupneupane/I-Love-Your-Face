class Photos < ActiveRecord::Migration
  def change
  	create_table :photos do |t|
  		t.integer :user_id
  		t.string  :type
  		t.date    :date_taken
  		t.boolean :single_person 
  		t.boolean :approved

  		t.timestamps
  	end

  	add_index :photos, :user_id
  end
end
