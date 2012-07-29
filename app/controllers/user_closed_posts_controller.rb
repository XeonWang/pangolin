class UserClosedPostsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
	    UserClosedPost.create(:user_id => session[:user_id], :post => @post, :post_time => @post.created_at)
	    respond_to do |format|
	      format.html { redirect_to posts_url }
	      format.json { head :no_content }
	    end
	end
end