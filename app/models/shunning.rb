class Shunning < ActiveRecord::Base
	attr_accessible :shunning_user_id, :shunned_user_id

	validates :shunned_user_id, uniqueness: {scope: :shunning_user_id}

	belongs_to :shunner, class_name: "User", foreign_key: :shunning_user_id
	belongs_to :shunnee, class_name: "User", foreign_key: :shunned_user_id
end