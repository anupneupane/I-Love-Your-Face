class ShunningsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :update_last_seen

	def create
		@shunning = Shunning.new(shunned_user_id: params[:shunned_user_id], shunning_user_id: params[:shunning_user_id])
		@shunning.save!

		if request.xhr?
			render nothing: true
		else
			redirect_to root_url
		end
	end

	def destroy
		@shunning = Shunning.where(shunned_user_id: params[:shunned_user_id], shunning_user_id: params[:shunning_user_id])[0]
		@shunning.destroy

		if request.xhr?
			render nothing: true
		else 
			redirect_to "/blacklist"
		end
	end

end