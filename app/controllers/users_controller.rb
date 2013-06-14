class UsersController < ApplicationController 
	before_filter :authenticate_user!
	before_filter :update_last_seen

	# log_visit requires "id" in the params to correspond to a user's id
	after_filter :log_visit
	skip_after_filter :log_visit, only: [:new, :create, :index, :destroy, :edit, :update]

	def show
		@user = User.find(params[:id])

		if current_user.users_who_shun_me.include?(@user)
			flash[:notice] = "You have been shunned!"
			redirect_to root_url
		end
	end

	def index
		# @newest_users = User.where('id != ?', current_user.id).order('id DESC')
		@newest_users = current_user.deselected_users.sort_by! {|user| user.id }.reverse
	end

	def edit
		@user = current_user
	end

	def profile_edit
		@user = current_user
	end

	def update
		@user = current_user
		
		if @user.update_attributes(params[:user])
			if request.xhr?
				render partial: "users/profile"
			else
				redirect_to user_url(current_user)
			end
		else 
			redirect_to user_url(current_user)
		end
	end

	def face_matches
		@users = current_user.best_matches
	end


end 