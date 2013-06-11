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
  
  has_many :photos

  has_many :types

  has_many :occurances_as_match, class_name: "TypeMatch", foreign_key: :user_id


  def add_pic_to_album(pic)
    #this does the work of calling the API with add method
    #the album is the same for everyone, pretty sure gonna keep it like that
  
    api_key = "EANeodQhAiTEapGd"
    api_secret = "aMAD2iBa1vtIRoI9"
    jobs = "face_add_[#{self.username}]"
    urls = pic.image.url
    app_name = "facemate_alpha"

    Unirest::post("http://rekognition.com/func/api/?api_key=#{api_key}&api_secret=#{api_secret}&jobs=#{jobs}&urls=#{urls}&name_space=#{app_name}")
  end

  def add_all_pics_to_album
    self.photos.each { |pic| add_pic_to_album(pic) }
  end


  def train_album
    api_key = "EANeodQhAiTEapGd"
    api_secret = "aMAD2iBa1vtIRoI9"
    jobs = "face_train"
    app_name = "facemate_alpha"

    Unirest::post("http://rekognition.com/func/api/?api_key=#{api_key}&api_secret=#{api_secret}&jobs=#{jobs}&name_space=#{app_name}")
  end


end
