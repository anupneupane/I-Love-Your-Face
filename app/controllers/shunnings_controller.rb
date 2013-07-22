class ShunningsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :update_last_seen

	def create
		@shunning = Shunning.new(shunned_user_id: params[:shunned_user_id], shunning_user_id: params[:shunning_user_id])
		@shunning.save!
		shunned_user_name = User.find(params[:shunned_user_id]).username

		if request.xhr?
			flash[:notice] = "Don't worry, " + shunned_user_name + " won't be bothering you anymore." if params[:on_profile] == "true"
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