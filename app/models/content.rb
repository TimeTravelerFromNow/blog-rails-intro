class Content < ApplicationRecord
  belongs_to :post
  has_rich_text :txt
  has_one_attached :img

  def paragraph?
    return kind == "paragraph"
  end

  def code?
    return kind == "code"
  end

  def image?
    return kind == "image"
  end
end
