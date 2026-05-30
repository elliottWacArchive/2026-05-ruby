class CreateCombatSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :combat_sessions do |t|
      t.references :character, null: false, foreign_key: true
      t.references :npc, null: false, foreign_key: true
      t.integer :character_hp, null: false
      t.integer :npc_hp, null: false
      t.string :status, null: false, default: "ongoing"  # ongoing, won, lost
      t.text :log  # historique des tours en JSON
      t.timestamps
    end
  end
end
