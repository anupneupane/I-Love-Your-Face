class PhotosController < ApplicationController 
	before_filter :authenticate_user!
	before_filter :update_last_seen

	def index 
		if params[:user_id]
			@viewed_user = User.find(params[:user_id])
			@photos = @viewed_user.photos.where(is_user: true)
		end
	end 


	def new
		@photo = Photo.new
	end

	def create 
		@photo = Photo.new(params[:photo])

		@photo.user_id = current_user.id 

		# take care of existing profile pics, don't forget to do this on update and delete!
		if @photo.is_profile_pic
			current_user.photos.each do |photo| 
				photo.is_profile_pic = false
				photo.save!
			end
		end

		if @photo.save
			redirect_to :back
		else
			flash[:notice] = 'Image did not save. Both width and height must be at least 700 pixels.'
			redirect_to :back
		end
	end

	def show 
		@photo = Photo.find(params[:id])
	end

end

