class SubscribeGroupsController < ApplicationController
	def create
		user = User.find(session[:user])
		user.subscribe_groups.create(:name => "New Group")
		render :text => user.subscribe_groups.first.name
	end
end