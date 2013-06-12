class Feedback < ActiveRecord::Base
	attr_accessible :feedback_giver_id, :feedback_receiver_id, :body, :read

	belongs_to :feedback_giver, class_name: "User", foreign_key: :feedback_giver_id
	belongs_to :feedback_receiver, class_name: "User", foreign_key: :feedback_receiver_id
end