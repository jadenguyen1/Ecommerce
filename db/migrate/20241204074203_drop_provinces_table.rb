class DropProvincesTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :provinces
  end
end
