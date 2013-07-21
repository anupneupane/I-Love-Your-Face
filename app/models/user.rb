class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable
         # , :confirmable

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :login, 
  								:password, :password_confirmation, :remember_me,
                  :num_likes, :last_like_refresh,
                  :birthdate, :sex, :zipcode,
                  :height, :weight, :body_type,
                  :relationship_status, :ethnicity, :orientation,
                  :about_me, :about_my_match, :dealbreakers

	def self.find_first_by_auth_conditions(warden_conditions)
	  conditions = warden_conditions.dup
	  if login = conditions.delete(:login)
	    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	  else
	    where(conditions).first
	  end
	end
  
  attr_accessor :face_matches

  def profile_pic
    self.photos.where(is_user: true, is_profile_pic: true).first
  end

  has_many :photos

  has_many :types

  has_many :occurances_as_match, class_name: "TypeMatch", foreign_key: :user_id

  # VISITS
  has_many :visited_profiles, class_name: "Visit", foreign_key: :visitor_id
  has_many :visitings, class_name: "Visit", foreign_key: :visitee_id

  has_many :visitors, through: :visitings, source: :visitor 
  has_many :visited_users, through: :visited_profiles, source: :visitee

  # LIKINGS
  has_many :likes_given, class_name: "Liking", foreign_key: :liking_user_id
  has_many :likes_received, class_name: "Liking", foreign_key: :liked_user_id

  has_many :users_who_like_me, through: :likes_received, source: :liker
  has_many :users_ive_liked, through: :likes_given, source: :likee

  # SHUNNING
  has_many :shuns_given, class_name: "Shunning", foreign_key: :shunning_user_id
  has_many :shuns_received, class_name: "Shunning", foreign_key: :shunned_user_id

  has_many :users_who_shun_me, through: :shuns_received, source: :shunner
  has_many :users_ive_shunned, through: :shuns_given, source: :shunnee

  # RATINGS
  has_many :ratings_given, class_name: "Rating", foreign_key: :rating_giver_id
  has_many :ratings_received, class_name: "Rating", foreign_key: :rating_receiver_id

  has_many :users_who_rated_me, through: :ratings_received, source: :rater
  has_many :users_ive_rated, through: :ratings_given, source: :ratee

  def avg_rating
    total_score = 0 
    self.ratings_received.each { |rating| total_score += rating.score }
    avg_rating = total_score / self.ratings_received.size.to_f
    avg_rating
  end

  # FEEDBACKS
  has_many :feedbacks_given, class_name: "Feedback", foreign_key: :feedback_giver_id
  has_many :feedbacks_received, class_name: "Feedback", foreign_key: :feedback_receiver_id

  has_many :users_who_gave_me_feedback, through: :feedbacks_received, source: :feedback_giver
  has_many :users_ive_given_feedback, through: :feedbacks_given, source: :feedback_receiver

  # MESSAGES
  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id
  has_many :received_messages, class_name: "Message", foreign_key: :recipient_id

  has_many :requested_conversation_partners, through: :sent_messages, source: :recipient 
  has_many :requesting_conversation_partners, through: :received_messages, source: :sender 

  def conversation_partners
    (self.requested_conversation_partners + self.requesting_conversation_partners).uniq
  end

  def shunned_pairs
    (self.users_who_shun_me + self.users_ive_shunned).uniq
  end


  # ***API METHODS***
  def find_pic_gender(pic)
    api_key = "EANeodQhAiTEapGd"
    api_secret = "aMAD2iBa1vtIRoI9"
    jobs = "face_gender"
    urls = pic.image.url
    app_name = "facemate_alpha2"

    response = Unirest::post("http://rekognition.com/func/api/?api_key=#{api_key}&api_secret=#{api_secret}&jobs=#{jobs}&urls=#{urls}&name_space=#{app_name}")  

    results = response.body["face_detection"][0]["sex"]
    results < 0.5 ? "female" : "male"
  end

  def add_pic_to_album(pic)
    #this does the work of calling the API with add method
    #there are albums for men and women. 
    #if the person hasn't specified their own gender one will be assigned to them. 
    if self.sex.nil?
      gender = find_pic_gender(pic)
      gender == "male" ? self.sex = "Male" : "Female"
      self.save!
    end

    api_key = "EANeodQhAiTEapGd"
    api_secret = "aMAD2iBa1vtIRoI9"
    jobs = "face_add_[#{self.username}]"
    urls = pic.image.url
    if self.sex == "Male"
      app_name = "facemate_male"
    else
      app_name = "facemate_female"
    end

    Unirest::post("http://rekognition.com/func/api/?api_key=#{api_key}&api_secret=#{api_secret}&jobs=#{jobs}&urls=#{urls}&name_space=#{app_name}")
  end

  def add_all_pics_to_album
    photos_of_me = self.photos.select { |photo| photo.is_user == true }
    photos_of_me.each { |pic| add_pic_to_album(pic) }
  end


  def train_album
    api_key = "EANeodQhAiTEapGd"
    api_secret = "aMAD2iBa1vtIRoI9"
    jobs = "face_train"
    app_name1 = "facemate_male"
    app_name2 = "facemate_female"

    Unirest::post("http://rekognition.com/func/api/?api_key=#{api_key}&api_secret=#{api_secret}&jobs=#{jobs}&name_space=#{app_name1}")
    Unirest::post("http://rekognition.com/func/api/?api_key=#{api_key}&api_secret=#{api_secret}&jobs=#{jobs}&name_space=#{app_name2}")
  end
  # ****END API METHODS***

  def deselected_users
    #filters out users that have shunned you or you have shunned
    #filters out conversation partners
    #filters you out of the results!
    results = User.all
    results.select! { |user| user.id != self.id }
    # results.select! { |user| !self.conversation_partners.include?(user) }
    results.select! { |user| !self.shunned_pairs.include?(user) }
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

  def find_face_matches_for_all_types
    matches = [] 
    self.try(:types).try(:each) {|type| matches += type.try(:find_all_matches) }
    @face_matches = average_results(matches)
    @face_matches.select! { |match| match[0] != self.username }

    @face_matches.map { |match| User.find_by_username(match[0]) }
  end

  # you can add in similar face matches later!


  def best_matches
    #use this for the front page photo grid
    #should exclude people you're already talking to
    #should exclude people you've shunned and who have shunned you
    #should prioritize face matches
    #should give second priority to people who have liked you
    #should give third priority to new members
    #should fill in the rest with whatever
    #should return 20 results (users)

    deselected_ids = self.deselected_users.map { |user| user.id }
    # like_matches = results.select { |result| self.users_who_like_me.include?(result) }
    face_matches = self.find_face_matches_for_all_types
    # all_matches = (face_matches + like_matches).uniq
    # all_matches ## this used to be returned, the algo needs tweaking
    face_matches.compact.select { |user| deselected_ids.include?(user.id) }
  end

  def remaining_likes
    if Date.today - self.last_like_refresh > 0
      self.last_like_refresh = Date.today
      self.num_likes = 5
      self.save!
      self.num_likes
    else
      self.num_likes
    end
  end
end
