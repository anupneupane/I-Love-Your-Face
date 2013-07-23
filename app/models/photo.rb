class Photo < ActiveRecord::Base
	attr_accessible :user_id, :photo_type, :photo_age, :approved, 
									:single_person, :is_user, :is_profile_pic, 
                  :is_match, :image

	has_attached_file :image, styles: { 
		large: "700x700>",
		small: "225x225#",
		thumb: "50x50#"
	}

  validate :file_dimensions, :if => :not_match, :unless => "errors.any?", on: :create

	belongs_to :user

	has_many :type_photos

  def file_dimensions
    dimensions = Paperclip::Geometry.from_file(self.image.queued_for_write[:original].path)
    if dimensions.width < 700 || dimensions.height < 700
      errors.add(:image, 'Both width and height must be at least 700 pixels')
    end
  end

  def not_match
    !self.is_match
  end
end
