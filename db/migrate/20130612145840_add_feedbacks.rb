class AddFeedbacks < ActiveRecord::Migration
  def change 
  	create_table :feedbacks do |t|
  		t.integer :feedback_giver_id
  		t.integer :feedback_receiver_id
  		t.text    :body

  		t.timestamps
  	end

  	add_index :feedbacks, :feedback_giver_id
  	add_index :feedbacks, :feedback_receiver_id
  end
end
