class Message < ActiveRecord::Base
	attr_accessible :sender_id, :recipient_id, :body, :read

	# validates :sender_id, :recipient_id, :body, presence: true

	belongs_to :sender, class_name: "User", foreign_key: :sender_id
	belongs_to :recipient, class_name: "User", foreign_key: :recipient_id
end 