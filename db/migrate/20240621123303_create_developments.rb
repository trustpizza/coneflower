class CreateDevelopments < ActiveRecord::Migration[7.1]
  def change
    create_table :developments do |t|
      t.string :name
      t.string :address
      t.float :acreage
      t.text :description
      t.string :website
      t.date :planned_start_date
      t.date :planned_end_date

      t.timestamps
    end
  end
end
