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
		if params[:page] && params[:page].to_i > 1
			start = 0 + ((params[:page].to_i - 1) * 5)
			stop = 5 + ((params[:page].to_i - 1) * 5)
		else
			start = 0
			stop = 5
			first_page = true 
		end 

		@users = current_user.deselected_users.sort_by! {|user| user.id }.reverse

		total_pages = (@users.size / 6.0).ceil

		@users = @users[start..stop]

		if request.xhr?
			render partial: "users/photo_grid", locals: {first_page: first_page, total_pages: total_pages}
		else
			render :index, locals: {first_page: first_page, total_pages: total_pages}
		end
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

	def browse
		#take care of likers here!
		@users = current_user.deselected_users
		@users.sort_by! do |user| 
			Liking.where(liking_user_id: user.id, liked_user_id: current_user.id).size
		end 
		@users.reverse!
	end

	def blacklist
		@users = current_user.users_ive_shunned
	end


end 