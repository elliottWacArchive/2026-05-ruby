class CreateQuestProgresses < ActiveRecord::Migration[8.1]
  def change
    create_table :quest_progresses do |t|
      t.references :character, null: false, foreign_key: true
      t.references :quest, null: false, foreign_key: true
      t.integer :current_step_index, null: false, default: 0
      t.string :status, null: false, default: "in_progress"  # in_progress, completed
      t.timestamps
    end

    add_index :quest_progresses, [:character_id, :quest_id], unique: true
  end
end
