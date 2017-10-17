class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.float :price
      t.integer :quantity
      t.text :description
      t.integer :year
      t.string :dimensions
      t.string :materials

      t.timestamps
    end
  end
end
