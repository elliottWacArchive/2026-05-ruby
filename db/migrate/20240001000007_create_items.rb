class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :slot, null: false  # hat, weapon, shield
      t.integer :hp_bonus, null: false, default: 0
      t.integer :strength_bonus, null: false, default: 0
      t.float :xp_multiplier, null: false, default: 1.0
      t.timestamps
    end
  end
end
