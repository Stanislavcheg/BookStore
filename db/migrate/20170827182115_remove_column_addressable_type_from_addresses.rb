class RemoveColumnAddressableTypeFromAddresses < ActiveRecord::Migration[5.1]
  def change
    remove_column :addresses, :addressable_type
  end
end
