class Profiles < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
  		t.integer :user_id
  		t.boolean :is_male
  		t.string  :orientation
  		t.integer :height
  		t.integer :weight
  		t.integer :zipcode
  		t.date    :birthdate
  		t.integer :distance_considered
  		t.text    :about_me
  		t.string  :body_type
  		t.text    :seeking
  		t.string  :ethnicity

  		t.timestamps
  	end

  	add_index :profiles, :user_id
  end
end
