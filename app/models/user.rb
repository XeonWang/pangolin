class User < ActiveRecord::Base
	validates :name, :presence => true
	def User::default_icon_url
	  "/images/icons/default.jpg"
	end
end
