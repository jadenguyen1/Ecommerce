class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  has_many :order_items
  has_one_attached :image

  validates :title, presence: true
  validates :stock, presence: true
  validates :price, presence: true
  validates :author_id, presence: true
  validates :genre_id, presence: true
  validate :correct_image_type

  private

  def correct_image_type
    if image.attached? && !image.content_type.in?(%w[image/png image/jpg image/jpeg])
      errors.add(:image, "must be a PNG, JPG, or JPEG")
    end
  end
end
