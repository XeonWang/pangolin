class FavoritesController < ApplicationController
	def create
		if session[:user_id] && params[:post_id]
			user = User.find(session[:user_id])
			user.favorites << Post.find(params[:post_id])
		end
		render :text => "{success}"
	end
end