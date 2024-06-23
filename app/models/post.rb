class Post < ApplicationRecord
  belongs_to :blog

  has_many :contents, dependent: :destroy
end
