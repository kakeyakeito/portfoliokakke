class AddUserIdToCommentToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comment_to_comments, :user_id, :integer
    add_column :comment_to_comments, :post_id, :integer
    add_column :comment_to_comments, :comment_to_comment, :text
  end
end
