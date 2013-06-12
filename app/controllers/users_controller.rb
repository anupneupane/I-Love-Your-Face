class UsersController < ApplicationController 
	before_filter :authenticate_user!
	after_filter :log_visit
	skip_after_filter :log_visit, only: [:new, :create, :index, :destroy, :edit, :update]

	
	def show
		@user = current_user 
	end
end 