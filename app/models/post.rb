class Post < ApplicationRecord


	 def self.search(search)
      if search
        Post.where(['title LIKE ?', "%#{search}%"])
      else
        Post.all
      end
    end

	belongs_to :user , optional: true

	has_many :comment, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	has_many :post_tags
	has_many :tags, through: :post_tags

	validates :title, presence: true

	def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
    end

	accepts_nested_attributes_for :tags, allow_destroy: true
end
