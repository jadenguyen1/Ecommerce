class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :address
      t.integer :province_id

      t.timestamps
    end
  end
end
