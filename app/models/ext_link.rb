class ExtLink < ApplicationRecord
  has_and_belongs_to_many :homes
  include IconsHelper

  def render_icon
    IconsHelper.icon(icon_class, fa_icon)
  end
end
