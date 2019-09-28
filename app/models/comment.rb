class Comment < ApplicationRecord
	has_many :comment_to_comments

	belongs_to :user
end
