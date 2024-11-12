class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.integer :stock
      t.boolean :sale
      t.decimal :price
      t.integer :author_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
