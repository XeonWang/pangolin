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

	def index
	    posts = Post.find(:all, :conditions => ["user_id = ? and source_id is not null", session[:user_id]], :include => :source)
	    item_template = File.read(Rails.root + "app/views/posts/_forward_item.jst")
	    response = JsonHtmlResponse.new
	    response.jst = item_template
	    response.data = posts.as_json(:include => [:user, :source])
	    respond_to do |format|
	      format.json { render json: response }
	    end
	end
end