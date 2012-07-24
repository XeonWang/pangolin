class SubscribeGroupsController < ApplicationController
	def create
		user = User.find(session[:user_id])
		group_name = params[:name]
		@new_group = user.subscribe_groups.build(:name => group_name)
		@new_group.member_ids = params[:member_users]
		@new_group.save
		render :inline =>"<%= link_to(@new_group.name) %>"
	end
end