class Home < ApplicationRecord
  has_rich_text :about
  has_many :blogs, dependent: :nullify
end
