class Province < ApplicationRecord
  has_many :users
  validates :name, :tax_rate, presence: true
end
