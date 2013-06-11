class Photo < ActiveRecord::Base
	attr_accessible :user_id, :location, :photo_type, :photo_age, :approved, :single_person, :is_user, :image

	has_attached_file :image, styles: { 
		large: "800x800",
		small: "300x300",
		thumb: "100x100#"
	}


	belongs_to :user

	has_many :type_photos

end
