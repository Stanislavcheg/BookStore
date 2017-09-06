class RemoveUserIdFromAddresses < ActiveRecord::Migration[5.1]
  def change
    remove_column :addresses, :user_id
  end
end
