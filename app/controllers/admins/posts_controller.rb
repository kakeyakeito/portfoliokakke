class Admins::PostsController < ApplicationController


	PER = 15


	def show
		@post = Post.find(params[:id])
		@favorite = Favorite.where(post_id: @post.id)
		@comments = Comment.where(post_id: @post.id)
		@user = @post.user
	end

	def index
		@posts = Post.all.page(params[:page]).per(PER)
	end

	def edit
		# 時間があれば
	end

	def update
		#時間があれば
	end

	def tag_post_index
		@tag = Tag.find(params[:id])
		@posts = @tag.chated_posts
	end

	def favorite_user_index
		@post = Post.find(params[:id])
		@users = @post.favorited_users
	end

	def destroy
		@post = Post.find(params[:id])
		if @post.destroy
			redirect_to admins_tags_path
		else
			redirect_to admins_user_path
		end
	end
end
