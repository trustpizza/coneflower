class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :development, null: false, foreign_key: true

      t.timestamps
    end
  end
end
