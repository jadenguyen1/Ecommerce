class DropAdminsTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :admins
  end
end