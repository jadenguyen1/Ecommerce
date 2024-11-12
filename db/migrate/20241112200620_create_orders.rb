class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.datetime :order_date
      t.decimal :total_price

      t.timestamps
    end
  end
end
