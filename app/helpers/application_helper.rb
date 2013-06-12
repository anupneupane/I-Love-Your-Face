module ApplicationHelper

	def log_visit
		#get rid of self-visits first
		return nil if params[:id].to_i == current_user.id

		#create a new visit event if one hasn't occurered in the last day
		last_visit = Visit.where(visitor_id: current_user.id, visitee_id: params[:id]).order('id DESC')[0]
		if last_visit
			if Time.now - last_visit.created_at > 43200
				Visit.create!(visitor_id: current_user.id, visitee_id: params[:id])
			end
		else
			Visit.create!(visitor_id: current_user.id, visitee_id: params[:id])
		end

		#return nil, purely a side effect method
		nil
	end
end
