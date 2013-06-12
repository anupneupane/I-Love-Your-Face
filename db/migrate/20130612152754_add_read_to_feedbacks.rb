class AddReadToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :read, :boolean
  end
end
