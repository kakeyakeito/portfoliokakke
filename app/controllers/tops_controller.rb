class TopsController < ApplicationController

	PER = 15

	before_action :authenticate_user!, except: [:top, :all_top, :about]

	def top
		@posts = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
	end

	def about
	end

	def follow_top
		@user = User.find(current_user.id)
		@follow_user = @user.followings
		@posts = Post.where(user_id: @follow_user).page(params[:page]).per(PER)
	end

	def all_top

		if user_signed_in? && current_user.blockeds.exists?
			@users = current_user.blockeds
			a = []
			@users.each do |user|
				a << user.id
			end
			@posts = Post.where.not(user_id: a).page(params[:page]).per(PER)
		else
			@posts = Post.all.page(params[:page]).per(PER)
		end
	end
end