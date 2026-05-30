class CreateRiddles < ActiveRecord::Migration[8.1]
  def change
    create_table :riddles do |t|
      t.references :step, null: false, foreign_key: true
      t.text :question, null: false
      t.timestamps
    end
  end
end
