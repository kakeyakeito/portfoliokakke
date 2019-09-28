class Tag < ApplicationRecord


	 def self.search(search)
      return Tag.all unless search
      Tag.where(['tag LIKE ?', "%#{search}%"])
    end

	has_many :post_tags
	has_many :posts, through: :post_tags
	has_many :chated_posts, through: :post_tags, source: :post
	validates :tag,uniqueness: true
end
