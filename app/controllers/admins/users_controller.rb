class Admins::UsersController < ApplicationController

	PER = 15

	def show
		@user = User.find(params[:id])
		@posts = @user.posts.all
	end

	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated User_infomation successfully."
      		redirect_to admins_users_path
      	else
      		render :edit
      	end
	end

	def favorite_index
		@user = User.find(params[:id])
		@posts = @user.favorited_posts.page(params[:page]).per(PER)
	end


	def following
		@user = User.find(params[:id])
		@users = @user.followings
		render "show_follow"
	end

	def followers
		user  = User.find(params[:id])
    	@users = @user.followers
    	render 'show_follower'
	end


	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to admins_users_path
		else
			redirect_to admins_tops_path
		end
	end

	private
	def user_params
		params.require(:user).permit(:name,:email)
	end
end
