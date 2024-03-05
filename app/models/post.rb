class Post < ApplicationRecord
  belongs_to :blog, optional: true
  validates :title, presence: true
end
