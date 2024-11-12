class User < ApplicationRecord
  belongs_to :province
  has_many :orders
  validates :username, presence: true
  validates :password, presence: true
  validates :province_id, presence: true
end
