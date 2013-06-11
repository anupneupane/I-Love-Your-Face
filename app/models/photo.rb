class Photo < ActiveRecord::Base
	attr_accessible :user_id, :location, :type, :date_taken, :approved, :image

	has_attached_file :image, styles: { 
		large: "800x800",
		small: "300x300",
		thumb: "100x100#"
	}

end
