class RemoveDimensionsColumnFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :dimensions, :string
  end
end
