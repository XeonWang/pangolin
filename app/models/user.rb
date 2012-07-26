class User < ActiveRecord::Base
	has_many :subscribe_groups
	has_and_belongs_to_many :favorites, :class_name => 'Post', :join_table => 'user_favorites'
	validates :name, :presence => true
	def User::default_icon_url
	  "/images/icons/default.jpg"
	end
end
