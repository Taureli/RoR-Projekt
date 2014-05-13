class User < ActiveRecord::Base
	before_save { self.email = email.downcase } #make all emails lowercase before saving
	before_create :create_remember_token		#create token before creating user

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50}
	validates :email, presence: true, format: { with:EMAIL_REGEX }, uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: { minimum: 6 }

	#generates token:
	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.digest(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end

  	private

  		#assigns token:
	    def create_remember_token
	      self.remember_token = User.digest(User.new_remember_token)
	    end

end
