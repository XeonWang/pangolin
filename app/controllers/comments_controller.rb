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
end