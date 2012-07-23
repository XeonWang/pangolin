class SubscribeGroupsController < ApplicationController
	def create
		user = User.find(session[:user_id])
		group_name = params[:name]
		@new_group = user.subscribe_groups.create(:name => group_name)
		render :inline =>"<%= link_to(@new_group.name) %>"
	end
end