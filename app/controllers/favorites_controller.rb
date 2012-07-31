class FavoritesController < ApplicationController
	def create
		if session[:user_id] && params[:post_id]
			user = User.find(session[:user_id])
			post = Post.find(params[:post_id])
			post = post.source if post.source
			user.favorites << post
		end
		render :text => "{success}"
	end

	def index
		user = User.find(session[:user_id])
	    posts = user.favorites
	    item_template = File.read(Rails.root + "app/views/posts/_favorite_item.jst")
	    response = JsonHtmlResponse.new
	    response.jst = item_template
	    response.data = posts.as_json(:include => [:user, :source])
	    respond_to do |format|
	      format.json { render json: response }
	    end
	end

	def destroy
		user = User.find(session[:user_id])
		post = Post.find(params[:id])
	    
	    user.favorites.delete(post)

	    respond_to do |format|
	      format.html { redirect_to posts_url }
	      format.json { head :no_content }
	    end
	end
end