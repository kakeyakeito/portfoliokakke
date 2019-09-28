class BlockRelationshipsController < ApplicationController

	def create
		@user = User.find(params[:block_relationship][:blocking_id])
		current_user.block!(@user)
		redirect_to @user
	end

	def destroy
		@user = BlockRelationship.find(params[:id]).blocking
		current_user.unblock!(@user)
		redirect_to @user
	end
end
