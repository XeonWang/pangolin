class SubscribeGroup < ActiveRecord::Base
	# has_and_belongs_to_many :users
	def self.get_next_name(user_id)
		last_unnamed = where("user_id = ? and name like 'New Group%'", user_id).order("name desc").first
		if last_unnamed then
			return last_unnamed.name.from(9).to_i
		else
			return 0
		end
	end
end
