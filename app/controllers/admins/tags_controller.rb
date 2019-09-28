class Admins::TagsController < ApplicationController

	def index
		@tags = Tag.all
	end

	def destroy
		# 必要かわからないのでまだ使わない
	end
end
