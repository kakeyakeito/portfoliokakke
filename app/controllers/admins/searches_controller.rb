class Admins::SearchesController < ApplicationController

	def search
		@number = params[:number]
		@search = params[:content]
		@result = 0
		case @number
		when "1"
			@result = User.search(@search)
			render :search
		when "2"
			@result = Tag.search(@search).page(params[:page]).per(PER)
			render :search

		when "3"
			@result = Post.search(@search).page(params[:page]).per(PER)
			render :search
		end
	end

end
