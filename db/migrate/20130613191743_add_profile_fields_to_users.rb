class AddProfileFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :age, :integer
  	add_column :users, :sex, :string
  	add_column :users, :zipcode, :integer
  	add_column :users, :height, :integer
  	add_column :users, :weight, :integer
  	add_column :users, :relationship_status, :string
  	add_column :users, :ethnicity, :string
  	add_column :users, :body_type, :string
  	add_column :users, :orientation, :string
  	add_column :users, :about_me, :text
  	add_column :users, :about_my_match, :text
  	add_column :users, :dealbreakers, :text
  end
end
