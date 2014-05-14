class Gist < ActiveRecord::Base
	 belongs_to :user
	 default_scope -> { order('created_at DESC') }
	 validates :snippet, presence: true, length:{ maximum:1200 }
	 validates :user_id, presence: true
end
