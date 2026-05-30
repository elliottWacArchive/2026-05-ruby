class CreateAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :answers do |t|
      t.references :riddle, null: false, foreign_key: true
      t.string :text, null: false
      t.boolean :correct, null: false, default: false
      t.timestamps
    end
  end
end
