class Type < ActiveRecord::Base
	attr_accessible :user_id, :photos_attributes

	belongs_to :user

	has_many :type_photos
	has_many :photos, through: :type_photos

	has_many :matches, class_name: "TypeMatch", foreign_key: :type_id
	has_many :matched_users, through: :matches, source: :user

	accepts_nested_attributes_for :photos 
	# , reject_if: lambda { |attributes| attributes["image"].blank? }




end