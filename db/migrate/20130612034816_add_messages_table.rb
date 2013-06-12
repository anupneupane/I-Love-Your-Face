class AddMessagesTable < ActiveRecord::Migration
  def change
  	create_table :messages do |t|
  		t.integer :recipient_id
  		t.integer :sender_id
  		t.text    :body
  		t.boolean :read

  		t.timestamps
  	end

  	add_index :messages, :recipient_id
  	add_index :messages, :sender_id
  end
end
