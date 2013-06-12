class Visit < ActiveRecord::Base
	attr_accessible :visitor_id, :visitee_id

	belongs_to :visitor, class_name: "User", foreign_key: :visitor_id
	belongs_to :visitee, class_name: "User", foreign_key: :visitee_id
end