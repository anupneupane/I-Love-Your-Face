class Photo < ActiveRecord::Base
	attr_accessible :user_id, :location, :type, :date_taken, :approved, :image

	mount_uploader :image, ImageUploader
end
