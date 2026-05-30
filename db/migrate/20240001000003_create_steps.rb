class CreateSteps < ActiveRecord::Migration[8.1]
  def change
    create_table :steps do |t|
      t.references :quest, null: false, foreign_key: true
      t.integer :position, null: false, default: 1
      t.integer :experience_reward, null: false, default: 30
      t.timestamps
    end

    add_index :steps, [:quest_id, :position]
  end
end
