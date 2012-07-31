class ForwardsController < ApplicationController
	def create
		source = Post.find(params[:post_id])
		source = source.source if source.source
		post = Post.new(:source => source)
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
	    deleted_post =  Post.new(:id => 0, :content => "Source file has been deleted...")

	    posts.each do |post|
	    	if !post.source
	    		post.source = deleted_post
	    	end
	    end

	    response.data = posts.as_json(:include => [:user, :source])
	    respond_to do |format|
	      format.json { render json: response }
	    end
	end

	def destroy
	    @post = Post.find(params[:id])
	    @post.destroy
	    # @post.destroy

	    respond_to do |format|
	      format.html { redirect_to posts_url }
	      format.json { head :no_content }
	    end
	end
end