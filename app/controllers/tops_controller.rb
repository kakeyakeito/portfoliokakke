class TopsController < ApplicationController

	PER = 15

	before_action :authenticate_user!, except: [:top, :all_top, :about]

	def top
		# ランキング機能
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
			@users.each do |user|
				@posts = Post.where.not(user_id: user.id).page(params[:page]).per(PER)
			end
		else
			@posts = Post.all.page(params[:page]).per(PER)
		end
	end
end
