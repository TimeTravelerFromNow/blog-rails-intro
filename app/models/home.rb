class Home < ApplicationRecord
  include IconsHelper

  has_rich_text :about
  has_many :blogs, dependent: :nullify
  has_and_belongs_to_many :ext_links

  validates_inclusion_of :site_icon_size, :in => 0..6
  validates_inclusion_of :site_width, :in => 400..2560

  def self.time_stamp
    home_time = "2022"
    home_time = Home.active_home.time_tag.year if Home.active_home.time_tag
    home_time
  end

  def self.active_home
    Home.all.where(active: true).first
  end

  def fa_icon
    icon_html(icon_class, icon, site_icon_size)
  end

  def self.fa_icon
    if Home.active_home
      return Home.active_home.fa_icon
    end
    "fa-brand fa-rebel"
  end

  def self.brand
    b = "my personal website"
    if Home.active_home
      b = Home.active_home.brand_name
    end
    b
  end

  def self.site_width
    site_width = 720
    site_width = Home.active_home.site_width if Home.active_home
    site_width
  end
end
