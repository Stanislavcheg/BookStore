class RemoveSoldColumnFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :sold, :integer
  end
end
