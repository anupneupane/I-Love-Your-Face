class LikingsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :update_last_seen

	def create
		user = User.find(params[:liking_user_id])

		unless user.remaining_likes == 0
			@liking = Liking.new(liked_user_id: params[:liked_user_id], liking_user_id: params[:liking_user_id])
			@liking.save!

			# decrement num of likes, this needs to happen automatically in the view!
			
			user.num_likes -= 1
			user.save!
		end
	
		if request.xhr?
			render partial: "users/remaining_likes"
		else
			redirect_to root_url
		end
	end

	def destroy

	end

	def index
		if params[:liked_user_id]
			@likings = Liking.where(liking_user_id: current_user.id, liked_user_id: params[:liked_user_id])
		end
		
		if request.xhr?
			render partial: "likings/user_to_user_likes"
		else
			render nothing: true
		end
	end


end