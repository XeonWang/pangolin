class SubscribeGroupsController < ApplicationController
	def create
		user = User.find(session[:user_id])
		index = SubscribeGroup.get_next_name(user.id)
		@new_group = user.subscribe_groups.create(:name => "New Group"+(index + 1).to_s)
		render :inline =>"<%= link_to(@new_group.name) %>"
	end
end