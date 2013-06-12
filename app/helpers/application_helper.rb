module ApplicationHelper

	def log_visit
		return nil if params[:user_id] == current_user.id 
		 
	end
end
