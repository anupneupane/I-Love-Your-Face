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
  								:password, :password_confirmation, :remember_me

	def self.find_first_by_auth_conditions(warden_conditions)
	  conditions = warden_conditions.dup
	  if login = conditions.delete(:login)
	    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	  else
	    where(conditions).first
	  end
	end
  
  attr_accessor :profile_pic

  def profile_pic
    @profile_pic || self.photos.where(is_user: true).first 
  end

  has_many :photos

  has_many :types

  has_many :occurances_as_match, class_name: "TypeMatch", foreign_key: :user_id

  has_many :visited_profiles, class_name: "Visit", foreign_key: :visitor_id
  has_many :visitings, class_name: "Visit", foreign_key: :visitee_id

  has_many :visitors, through: :visitings, source: :visitor 
  has_many :visited_users, through: :visited_profiles, source: :visitee

  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id
  has_many :received_messages, class_name: "Message", foreign_key: :recipient_id

  has_many :requested_conversation_partners, through: :sent_messages, source: :recipient 
  has_many :requesting_conversation_partners, through: :received_messages, source: :sender 

  def conversation_partners
    (self.requested_conversation_partners + self.requesting_conversation_partners).uniq
  end

  # ***API METHODS***
  def add_pic_to_album(pic)
    #this does the work of calling the API with add method
    #the album is the same for everyone, pretty sure gonna keep it like that
  
    api_key = "EANeodQhAiTEapGd"
    api_secret = "aMAD2iBa1vtIRoI9"
    jobs = "face_add_[#{self.username}]"
    urls = pic.image.url
    app_name = "facemate_alpha2"

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
    app_name = "facemate_alpha2"

    Unirest::post("http://rekognition.com/func/api/?api_key=#{api_key}&api_secret=#{api_secret}&jobs=#{jobs}&name_space=#{app_name}")
  end
  # ****END API METHODS***


end
