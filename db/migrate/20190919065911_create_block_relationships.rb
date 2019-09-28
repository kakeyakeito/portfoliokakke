class CreateBlockRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :block_relationships do |t|
      t.integer :blocked_id
      t.integer :blocking_id

      t.timestamps null: false
    end


    add_index :block_relationships, :blocked_id
    add_index :block_relationships, :blocking_id
    add_index :block_relationships, [:blocked_id, :blocking_id], unique: true
  end
end
