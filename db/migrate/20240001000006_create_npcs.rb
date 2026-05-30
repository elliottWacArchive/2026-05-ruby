class CreateNpcs < ActiveRecord::Migration[8.1]
  def change
    create_table :npcs do |t|
      t.references :step, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :hp, null: false, default: 20
      t.integer :strength, null: false, default: 5
      t.timestamps
    end
  end
end
