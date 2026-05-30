class CreateQuests < ActiveRecord::Migration[8.1]
  def change
    create_table :quests do |t|
      t.string :name, null: false
      t.text :description
      t.integer :completion_xp, null: false, default: 200
      t.timestamps
    end
  end
end
