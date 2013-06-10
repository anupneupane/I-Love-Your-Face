class PhotosController < ApplicationController 

	def new
		@photo = Photo.new
	end

	def create 
		@photo = Photo.new(params[:photo])

		if @photo.save!
			puts "success!"
		else
			puts "failure!"
		end
	end

	def show 
		@photo = Photo.find(params[:id])
	end

end

