class ChangeZipcodeToStringOnUsersTable < ActiveRecord::Migration
  def change
  	remove_column :users, :zipcode 
  	add_column :users, :zipcode, :string
  end
end
