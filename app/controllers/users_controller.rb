class UsersController < ApplicationController

	before_action :authenticate_user!

	PER = 15


	def show
		@user = User.find(params[:id])
		@users =  @user.blockings
		@posts = @user.posts.page(params[:page]).per(PER)
		@comments = Comment.all
		# DM
		@currentUserEntry = Entry.where(user_id: current_user.id)
	    @userEntry = Entry.where(user_id: @user.id)
	    if @user.id == current_user.id
	    else
	      @currentUserEntry.each do |cu|
	        @userEntry.each do |u|
	          if cu.room_id == u.room_id then
	            @isRoom = true
	            @roomId = cu.room_id
	          end
	        end
	      end
	      if @isRoom
	      else
	        @room = Room.new
	        @entry = Entry.new
	      end
	    end
	end

	def mypage
		@user = User.find(params[:id])
		@posts = @user.posts.page(params[:page]).per(PER)
		@comments = Comment.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated User_infomation successfully."
      		redirect_to mypage_user_path(current_user.id)
      	else
      		render :edit
      	end

	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to root_path
		end
	end

	# Block機能

	def blocking
		@user = User.find(params[:id])
		@users = @user.blockings
		render "show_block"
	end

	def blockeds
		@user = User.find(params[:id])
		@users = @user.blockeds
		render "show_blocker"
	end

	def block_index
		@user = current_user
		@users = @user.blockings
	end


# UserがいいねしているPostの一覧
	def favorite_index
		@user = User.find(params[:id])
		@posts = @user.favorited_posts.page(params[:page]).per(PER)
	end


# フォロー機能
	def following
		@user = User.find(params[:id])
		@users = @user.followings
		render "show_follow"
	end

	def followers
		@user  = User.find(params[:id])
    	@users = @user.followers
    	render 'show_follower'
	end

	private
	def user_params
		params.require(:user).permit(:name,:email)
	end

end
