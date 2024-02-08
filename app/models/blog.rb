class Blog < ApplicationRecord

  has_rich_text :story

  has_one_attached :header_image
end
