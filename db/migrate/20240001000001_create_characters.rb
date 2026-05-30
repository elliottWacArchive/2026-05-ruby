class CreateCharacters < ActiveRecord::Migration[8.1]
  def change
    create_table :characters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :level, null: false, default: 1
      t.integer :experience, null: false, default: 0
      t.integer :base_hp, null: false, default: 10
      t.integer :base_strength, null: false, default: 10
      t.integer :unspent_points, null: false, default: 10
      t.integer :gold, null: false, default: 0
      t.timestamps
    end
  end
end
