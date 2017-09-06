class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.bigint :number
      t.string :name
      t.string :expires
      t.integer :cvv
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
