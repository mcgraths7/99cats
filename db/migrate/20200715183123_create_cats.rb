class CreateCats < ActiveRecord::Migration[5.2]
  def change
    create_table :cats do |t|
      t.string :name, null: false, index: true
      t.date :birth_date, null: false
      t.string :color, null: false
      t.string :sex, limit: 1, null: false
      t.text :description, null: false
      t.timestamps
    end
  end
end
