class CreateInventories < ActiveRecord::Migration[8.1]
  def change
    create_table :inventories do |t|
      t.references :character, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.boolean :equipped, null: false, default: false
      t.timestamps
    end

    add_index :inventories, [:character_id, :item_id]
  end
end
