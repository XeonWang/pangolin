class ForwardsController < ApplicationController
	def create
		post = Post.new(:source_id => params[:post_id])
	    post.user = User.find(session[:user_id])
	    respond_to do |format|
	      if post.save
	        # format.html { redirect_to @post, notice: 'Post was successfully created.' }
	        format.json { render json: post, :status => :created }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @post.errors, status: :unprocessable_entity }
	      end
	    end
	end
end