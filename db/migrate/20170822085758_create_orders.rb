class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.float :subtotal
      t.string :order_number
      t.float :total
      t.references :order_status, foreign_key: true
      t.references :coupon, foreign_key: true

      t.timestamps
    end
  end
end
