class Liking < ActiveRecord::Base
	attr_accessible :liking_user_id, :liked_user_id

	belongs_to :liker, class_name: "User", foreign_key: :liking_user_id
	belongs_to :likee, class_name: "User", foreign_key: :liked_user_id
end