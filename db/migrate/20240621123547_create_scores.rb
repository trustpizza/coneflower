class CreateScores < ActiveRecord::Migration[7.1]
  def change
    create_table :scores do |t|
      t.integer :value
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
