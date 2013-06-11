class TypeMatch < ActiveRecord::Base
	attr_accessible :user_id, :type_id 

	belongs_to :user 
	belongs_to :type 
end 