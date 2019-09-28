class AddUserIdToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :user_id, :integer
    add_column :entries, :room_id, :integer
  end
end
