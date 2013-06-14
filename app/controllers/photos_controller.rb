class PhotosController < ApplicationController 
	before_filter :authenticate_user!
	before_filter :update_last_seen

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

		# take care of existing profile pics, don't forget to do this on update and delete!
		if @photo.is_profile_pic
			current_user.photos.where(is_user: true).map! { |photo| photo.is_profile_pic = false }
		end

		if @photo.save!

			#again, set the profile pic on the user for easy access
			if @photo.is_profile_pic
				current_user.profile_pic = @photo
			end
			
			redirect_to :back
		else
			redirect_to :back
		end
	end

	def show 
		@photo = Photo.find(params[:id])
	end

end

