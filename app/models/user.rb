class User < ActiveRecord::Base
	has_many :subscribe_groups
	validates :name, :presence => true
	def User::default_icon_url
	  "/images/icons/default.jpg"
	end
end
