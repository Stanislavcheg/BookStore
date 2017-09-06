class RemoveOrderIdColumnFromDeliveries < ActiveRecord::Migration[5.1]
  def change
    remove_column :deliveries, :order_id
  end
end
