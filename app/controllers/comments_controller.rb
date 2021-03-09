class CommentsController < ApplicationController

	before_action :authenticate_user!

	def index
		@comments = @post.comments.includes(:user)
	end

	def create
		@comment = Comment.new(comment_params)
		# if comment is created successfully, make a @post varaible to store it's id for use in view's form_for
		if @comment.save
			@post = @comment.post
			respond_to :js
		else
			flash[:alert] = "Something went wrong ..."
		end
	end

	def destroy
		@comment = Comment.find_by(params[:id])
		@post = @comment.post
		if @comment.destroy
			respond_to :js
		else
			flash[:alert] = "Something went wrong ..."
		end
	end

	private
	def comment_params
		params.require(:comment).permit :user_id, :post_id, :content
	end

end
