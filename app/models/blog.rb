class Blog < ApplicationRecord

  has_rich_text :story

  has_one_attached :header_image

  validates :address, presence: true
  validates_uniqueness_of :address

  def to_param
    address
  end
end
