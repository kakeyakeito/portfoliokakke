class FavoritesController < ApplicationController

  before_action :set_variables
  before_action :authenticate_user!



	def create
    	favorite = current_user.favorites.new(post_id: @post.id)
    	favorite.save
    	render json: @post.id
 	end

  	def destroy
    	favorite = current_user.favorites.find_by(post_id: @post.id)
    	favorite.destroy
    	render json: @post.id
  	end

  	private
  	def set_variables
  		@post = Post.find(params[:post_id])
  		@id_name = "#favorite-link-#{@post.id}"

  	end
end


