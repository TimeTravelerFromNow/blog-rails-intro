class Content < ApplicationRecord
  belongs_to :post

  has_rich_text :paragraph
  has_one_attached :image
end
