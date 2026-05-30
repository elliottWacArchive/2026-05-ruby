class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.references :npc, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.text :content, null: false
      t.timestamps
    end
  end
end
