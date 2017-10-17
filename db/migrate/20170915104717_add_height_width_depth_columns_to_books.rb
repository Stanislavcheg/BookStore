class AddHeightWidthDepthColumnsToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :height, :float
    add_column :books, :width, :float
    add_column :books, :depth, :float
  end
end
