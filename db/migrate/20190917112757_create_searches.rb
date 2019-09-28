class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.integer :number
      t.text :content

      t.timestamps
    end
  end
end
