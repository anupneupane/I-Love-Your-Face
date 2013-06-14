class TypesController < ApplicationController 
	before_filter :authenticate_user!
	before_filter :update_last_seen

	def new
		@type = Type.new
		@type.photos.build
	end

	def create
		@type = Type.new(params[:type])
		@type.user_id = current_user.id 
		@type.save!

		redirect_to :back
	end


end 