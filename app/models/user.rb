class User < ApplicationRecord
  belongs_to :province
  has_many :orders
  has_secure_password

  validates :username, presence: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :province_id, presence: true
  validates :address, presence: true
end
