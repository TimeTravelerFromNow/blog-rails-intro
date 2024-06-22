class Home < ApplicationRecord
  include IconsHelper
  VALID_SITE_WIDTHS = 400..2560

  has_rich_text :about
  has_many :blogs, dependent: :nullify
  has_and_belongs_to_many :ext_links, dependent: :nullify

  validates_presence_of :site_icon_size
  validates_inclusion_of :site_icon_size, :in => VALID_ICON_SIZES
  validates_inclusion_of :site_width, :in => VALID_SITE_WIDTHS

  before_save :activate_when_none_active
  def activate_when_none_active
    self.active = true if Home.active_home.nil?
  end

  def self.time_stamp
    home_time = "2022"
    return home_time unless Home.active_home
    home_time = Home.active_home.time_tag.year if Home.active_home.time_tag
    home_time
  end

  def self.active_home
    Home.all.where(active: true).first
  end

  def fa_icon
    icon_class ||= 'fa-solid'
    icon ||= 'fa-robot'
    icon_html(icon_class, icon, site_icon_size)
  end

  def self.fa_icon
    return "<i class='fa-solid fa-robot'></i>" unless Home.active_home
    home_icon = Home.active_home.fa_icon if Home.active_home.fa_icon
    home_icon
  end

  def self.brand
    bn = "my personal website"
    return bn unless Home.active_home
    bn = Home.active_home.brand_name if Home.active_home.brand_name
    bn
  end

  def self.site_width
    site_width = 720
    return site_width unless Home.active_home
    site_width = Home.active_home.site_width if Home.active_home.site_width
    site_width
  end
end
