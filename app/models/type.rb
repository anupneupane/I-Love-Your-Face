class Type < ActiveRecord::Base
	attr_accessible :user_id, :photos_attributes

	belongs_to :user

	has_many :type_photos
	has_many :photos, through: :type_photos

	has_many :matches, class_name: "TypeMatch", foreign_key: :type_id
	has_many :matched_users, through: :matches, source: :user

	accepts_nested_attributes_for :photos 
	# , reject_if: lambda { |attributes| attributes["image"].blank? }

  def find_pic_gender(pic)
    api_key = "EANeodQhAiTEapGd"
    api_secret = "aMAD2iBa1vtIRoI9"
    jobs = "face_gender"
    urls = pic.image.url
    app_name = "facemate_alpha2"

    response = Unirest::post("http://rekognition.com/func/api/?api_key=#{api_key}&api_secret=#{api_secret}&jobs=#{jobs}&urls=#{urls}&name_space=#{app_name}")  

    results = response.body["face_detection"][0]["sex"]
    results < .5 ? "female" : "male"
  end

  def find_pic_matches(pic)
    api_key = "EANeodQhAiTEapGd"
    api_secret = "aMAD2iBa1vtIRoI9"
    jobs = "face_recognize"
    urls = pic.image.url

    gender = find_pic_gender(pic)
    app_name = "facemate_" + gender

    response = Unirest::post("http://rekognition.com/func/api/?api_key=#{api_key}&api_secret=#{api_secret}&jobs=#{jobs}&urls=#{urls}&name_space=#{app_name}")  

    results = response.body["face_detection"][0]["name"].split(",").map {|result| result.split(":")} 
    results.map! { |result| [result[0], result[1].to_f] }

    results
  end

  def average_results(results)
  	users = results.map { |result| result[0] }.uniq

  	users_scores = users.map do |user|
  		user_events = results.select {|result| result[0] == user}
  		sum = 0
  		user_events.each { |event| sum += event[1] }
  		avg = sum.to_f / user_events.size
  		[user, avg]
  	end

  	users_scores.sort_by { |user_score| user_score[1] }.reverse
  end

  def find_all_matches
  	matches = []
  	self.photos.each do |pic|
  		matches += find_pic_matches(pic)
  	end
  	
  	final_matches = average_results(matches)
  	final_matches
  end

end