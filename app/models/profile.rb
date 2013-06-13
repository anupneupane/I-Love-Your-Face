class Profile < ActiveRecord::Base
	attr_accessible :user_id, :is_male, :orientation, 
									:height, :weight, :zipcode, 
									:birthdate, :distance_considered, 
									:about_me, :body_type, :seeking, :ethnicity 



	belongs_to :user
end