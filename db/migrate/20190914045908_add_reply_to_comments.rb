class AddReplyToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :reply, :integer
  end
end
