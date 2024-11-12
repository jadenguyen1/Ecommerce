class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :order_id, presence: true
  validates :book_id, presence: true
end
