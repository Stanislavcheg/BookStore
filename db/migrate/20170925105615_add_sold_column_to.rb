class AddSoldColumnTo < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :sold, :integer, default: 0
  end
end
