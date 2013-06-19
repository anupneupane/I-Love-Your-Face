class Photo < ActiveRecord::Base
	attr_accessible :user_id, :photo_type, :photo_age, :approved, 
									:single_person, :is_user, :is_profile_pic, :image

	has_attached_file :image, styles: { 
		large: "700x700>",
		small: "225x225#",
		thumb: "100x100#"
	}


	belongs_to :user

	has_many :type_photos
end
