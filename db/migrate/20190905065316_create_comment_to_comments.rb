class CreateCommentToComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_to_comments do |t|
      t.integer :comment_id,null: false
      t.timestamps
    end
  end
end
