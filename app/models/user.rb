class User < ActiveRecord::Base
before_save { self.email = email.downcase } #make all emails lowercase before saving
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 15}
	validates :email, presence: true, format: { with:EMAIL_REGEX }, uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: { minimum: 6 }
end
