class PostsController < ApplicationController

	before_action :authenticate_user!

	PER = 15


	def show
		@post = Post.find(params[:id])
		@favorite = Favorite.where(post_id: @post.id, user_id: current_user.id)
		@comments = Comment.where(post_id: @post.id)
		@user = @post.user
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		number = 1
		if @post.save
			puts tag_params
			tag_params[:tags_attributes]
			if params[:post][:tags_attributes]
				params[:post][:tags_attributes].each do |post_tag|
					@tag = Tag.find_or_create_by(tag: post_tag[1][:tag])
					PostTag.create(post_id:@post.id, tag_id: @tag.id)
				end
			end

				redirect_to mypage_user_path(current_user.id)
		else
			render :new
		end
	end


# Tagが持つPost一覧
	def tag_post_index
		@tag = Tag.find(params[:id])
		@posts = @tag.chated_posts.page(params[:page]).per(PER)
	end

# いいねしたUser一覧
	def favorite_user_index
		@post = Post.find(params[:id])
		@users = @post.favorited_users
	end


	def new
		@post = Post.new
	end

	def edit
		@post = Post.find(params[:id])
		if @post.user_id == current_user

		else
			redirect_to root_path
		end
	end



	def update
		#@post = Post.find(params[:id])
		#@post.user_id = current_user.id 時間があれば
	end

	def destroy
		@post = Post.find(params[:id])
		if @post.destroy
			redirect_to mypage_user_path(current_user.id)
		else
			redirect_to mypage_user_path(current_user.id)
		end
	end

	private
	def post_params
		params.require(:post).permit(:title)
	end

	def tag_params
		params.require(:post)
	end
end
