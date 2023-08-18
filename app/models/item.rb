class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_one_attached :image

end
