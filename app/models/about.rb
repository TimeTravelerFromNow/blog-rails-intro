class About < ApplicationRecord
  belongs_to :blog, optional: true
  has_rich_text :story
end
