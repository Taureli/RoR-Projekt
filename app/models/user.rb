class User < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 15}
	validates :email, presence: true, format: 
end
