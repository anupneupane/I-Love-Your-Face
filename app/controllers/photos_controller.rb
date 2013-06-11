class PhotosController < ApplicationController 
	before_filter :authenticate_user!

	def index 
		if params[:user_id]
			@viewed_user = User.find(params[:user_id])
			@photos = @viewed_user.photos.where(is_user: true)
		end

		puts "NOOOOOOO"
	end 


	def new
		@photo = Photo.new
	end

	def create 
		@photo = Photo.new(params[:photo])
		@photo.user_id = current_user.id 

		if @photo.save!
			redirect_to :back
		else
			redirect_to :back
		end
	end

	def show 
		@photo = Photo.find(params[:id])
	end

end

