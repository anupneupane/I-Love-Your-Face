class ChangeAgeToBirthdate < ActiveRecord::Migration
  def change
  	remove_column :users, :age 
  	add_column :users, :birthdate, :date
  end
end
