class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_to_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post

  #DM
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries

# follow機能
  has_many :following_relationships, foreign_key: "follower_id", class_name:"Relationship", dependent: :destroy

  has_many :followings, through: :following_relationships

  has_many :follower_relationships, foreign_key: "following_id", class_name:"Relationship", dependent: :destroy

  has_many :followers, through: :follower_relationships


# block機能

  has_many :blocking_block_relationships, foreign_key: "blocked_id", class_name:"BlockRelationship", dependent: :destroy

  has_many :blockings, through: :blocking_block_relationships

  has_many :blocked_block_relationships, foreign_key: "blocking_id", class_name:"BlockRelationship", dependent: :destroy

  has_many :blockeds, through: :blocked_block_relationships


# 検索機能

   def self.search(search)
      return User.all unless search
      User.where(['name LIKE ?', "%#{search}%"])
    end

# follow機能

  def following?(other_user)
  	following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
  	following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
  	following_relationships.find_by(following_id: other_user.id).destroy
  end

# block機能

  def blocking?(other_user)
    blocking_block_relationships.find_by(blocking_id: other_user.id)
  end

  def block!(other_user)
    blocking_block_relationships.create!(blocking_id: other_user.id)
  end

  def unblock!(other_user)
    blocking_block_relationships.find_by(blocking_id: other_user.id).destroy
  end

# バリデーション
  validates :name, presence: true
end
