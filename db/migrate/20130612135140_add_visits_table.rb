class AddVisitsTable < ActiveRecord::Migration
  def change 
  	create_table :visits do |t|
  		t.integer :visitor_id
  		t.integer :visitee_id

  		t.timestamps
  	end

  	add_index :visits, :visitor_id
  	add_index :visits, :visitee_id
  end
end
