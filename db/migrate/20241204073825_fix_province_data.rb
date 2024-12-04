class FixProvinceData < ActiveRecord::Migration[7.2]
  def up
    # Update province records where 'name' is a number and 'tax_rate' is a string
    Province.where("name LIKE '%-%'").each do |province|
      # If the name contains a number (tax rate), move the value to the tax_rate column
      name = province.name
      tax_rate = name.to_f
      province.update(name: tax_rate == 0.0 ? 'Unknown' : name, tax_rate: tax_rate)
    end
  end

  def down
    # This down method can reverse any changes, but in this case it’s just a basic cleanup of records
    Province.update_all(tax_rate: 0.0) # Default all tax_rate values to 0.0
  end
end
