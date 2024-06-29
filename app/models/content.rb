class Content < ApplicationRecord
  belongs_to :post

  has_rich_text :paragraph
  has_one_attached :image

  def image_safe
    return 'dipper-img.png' unless image.persisted?
    image
  end
end
