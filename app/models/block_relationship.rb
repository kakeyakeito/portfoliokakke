class BlockRelationship < ApplicationRecord
	belongs_to :blocking, class_name: "User"
	belongs_to :blocked, class_name: "User"
	validates :blocking_id, presence: true
	validates :blocked_id, presence: true
end
