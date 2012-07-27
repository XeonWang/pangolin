class FavoritesController < ApplicationController
	def create
		if session[:user_id] && params[:post_id]
			user = User.find(session[:user_id])
			user.favorites << Post.find(params[:post_id])
		end
		render :text => "{success}"
	end

	def index
		user = User.find(session[:user_id])
	    posts = user.favorites
	    item_template = File.read(Rails.root + "app/views/posts/_item.jst")
	    response = JsonHtmlResponse.new
	    response.jst = item_template
	    response.data = posts.as_json(:include => [:user, :source])
	    respond_to do |format|
	      format.json { render json: response }
	    end
	end
end