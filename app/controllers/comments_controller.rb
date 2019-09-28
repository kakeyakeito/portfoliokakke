class CommentsController < ApplicationController

	before_action :authenticate_user!
	def new
		@comment = Comment.new
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = Comment.new(comment_params)
		@number = Comment.where(post_id:params[:post_id])
		@comment.number = @number.length + 1
		@comment.post_id = @post.id
		@comment.user_id = current_user.id
		if @comment.save
			redirect_to post_path(@post)
		else
			render :new
		end
	end


	def reply
		@comment = Comment.new
		@reply = Comment.find(params[:id])
	end

	def reply_create
		@post = Post.find(params[:post_id])
		@reply = Comment.find(params[:id])
		@comment = Comment.new(comment_params)
		@number = Comment.where(post_id:params[:post_id])
		@comment.number = @number.length + 1
		@comment.post_id = @post.id
		@comment.user_id = current_user.id
		if @comment.save
			redirect_to post_path(@post)
		else
			render :new
		end
	end


	def destroy
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		if @comment.destroy
			redirect_to post_path(@post)
		else
			render :show
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:comment,:reply,:number)
	end
end
