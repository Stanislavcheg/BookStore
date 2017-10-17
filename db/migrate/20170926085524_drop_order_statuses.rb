class DropOrderStatuses < ActiveRecord::Migration[5.1]
  def change
    drop_table :order_statuses, force: :cascade
  end
end
