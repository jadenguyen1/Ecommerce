class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  has_many :order_items
  validates :title, presence: true
  validates :stock, presence: true
  validates :price, presence: true
  validates :author_id, presence: true
  validates :genre_id, presence: true
end
