class UsersController < ApplicationController 
	before_filter :authenticate_user!

	# log_visit requires "id" in the params to correspond to a user's id
	after_filter :log_visit
	skip_after_filter :log_visit, only: [:new, :create, :index, :destroy, :edit, :update]

	def show
		if current_user.profile.nil? 
			p = Profile.new(user_id: current_user.id)
			p.save!
		end

		@user = User.find(params[:id])
	end

	def index
		@newest_users = User.where('id != ?', current_user.id).order('id DESC')
	end
end 