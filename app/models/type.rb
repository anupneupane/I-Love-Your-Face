class Type < ActiveRecord::Base
	attr_accessible :user_id

	belongs_to :user

	has_many :type_photos 

	has_many :matches, class_name: "TypeMatch", foreign_key: :type_id
	has_many :matched_users, through: :matches, source: :user
end