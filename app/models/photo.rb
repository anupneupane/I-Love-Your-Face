class Photo < ActiveRecord::Base
	attr_accessible :user_id, :location, :type, :date_taken, :approved

end
