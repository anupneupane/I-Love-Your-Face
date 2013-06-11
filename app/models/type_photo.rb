class TypePhoto < ActiveRecord::Base
	attr_accessible :type_id, :photo_id

	belongs_to :type 
	belongs_to :photo 
end