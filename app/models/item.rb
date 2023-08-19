class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app', 'assets', 'images', 'no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [250, 200]).processed
  end



end
