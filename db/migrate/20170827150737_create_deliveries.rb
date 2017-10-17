class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.string :method
      t.string :days
      t.float :price
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
