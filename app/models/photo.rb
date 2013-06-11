class Photo < ActiveRecord::Base
	attr_accessible :user_id, :location, :type, :date_taken, :approved, :image

	has_attached_file :image, styles: { 
		big: "600x600",
		small: "100x100#"
	}

end
