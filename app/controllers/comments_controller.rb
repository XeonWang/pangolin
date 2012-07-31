class CommentsController < ApplicationController
	def index
		comments = Comment.where("user_id = ?", session[:user_id])
		item_template = File.read(Rails.root + "app/views/comments/_item.jst")
	    response = JsonHtmlResponse.new
	    response.jst = item_template
	    response.data = comments
	    respond_to do |format|
	      format.json { render json: response }
	    end
	end

	def destroy
		@comment = Comment.find(params[:id])
	    @comment.destroy

	    respond_to do |format|
	      format.html { redirect_to posts_url }
	      format.json { head :no_content }
	    end
	end
end