class Rating < ActiveRecord::Base
	attr_accessible :rating_giver_id, :rating_receiver_id, :score

	belongs_to :rater, class_name: "User", foreign_key: :rating_giver_id
	belongs_to :ratee, class_name: "User", foreign_key: :rating_receiver_id
end