class Blog < ApplicationRecord
  has_many :posts
  has_rich_text :story
  belongs_to :home, optional: true

  has_one_attached :header_image

  validates :address, presence: true
  validates_uniqueness_of :address

  def to_param
    address
  end

  def featured?
    home != nil
  end
end
