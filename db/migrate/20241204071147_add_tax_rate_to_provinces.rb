# db/migrate/[timestamp]_add_tax_rate_to_provinces.rb
class AddTaxRateToProvinces < ActiveRecord::Migration[6.1]
  def change
    add_column :provinces, :tax_rate, :decimal, precision: 5, scale: 2, null: false, default: 0.0
  end
end
