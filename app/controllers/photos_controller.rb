class PhotosController < ApplicationController 
	before_filter :authenticate_user!
	before_filter :update_last_seen

	def index 
		if params[:user_id]
			@viewed_user = User.find(params[:user_id])
			@photos = @viewed_user.photos.where(is_user: true)
			profile_index = @photos.find_index { |p| p.is_profile_pic == true }
			unless profile_index.nil? 
				photo_end = profile_index + 1 
				@photos = [@photos[profile_index]] + @photos[0...profile_index] + @photos[photo_end..-1]
			end
			@photos
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
			flash[:notice] = 'Photo added!'
			redirect_to :back
		else
			flash[:notice] = 'Image did not save. Both width and height must be at least 700 pixels.'
			redirect_to :back
		end
	end

	def show 
		@photo = Photo.find(params[:id])
	end

	def update
		@photo = Photo.find(params[:id])

		if params[:change_profile_pic]
			current_user.photos.each do |photo| 
				photo.is_profile_pic = false
				photo.save!
			end
			@photo.is_profile_pic = true 
			@photo.save!
		end

		render nothing: true
	end


	def destroy
		@photo = Photo.find(params[:id])
		@photo.destroy

		if request.xhr? 
			render nothing: true
		else
			flash[:notice] = 'Photo deleted!'
			redirect_to :back
		end
	end
end

