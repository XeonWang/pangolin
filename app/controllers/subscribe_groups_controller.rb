class SubscribeGroupsController < ApplicationController
	def create
		@user = User.find(session[:user_id])
		@user.subscribe_groups.create(:name => "New Group")
		render :inline =>"<%= link_to(@user.subscribe_groups.first.name) %>"
	end
end