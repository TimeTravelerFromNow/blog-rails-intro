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

  # Instance methods
  def activate_when_none_active
    self.active = true unless Home.active_home.active
  end

  def fa_icon
    icon_html(icon_class, icon, site_icon_size)
  end


  # Class/singleton methods
  def self.fa_icon
    active_home.fa_icon
  end

  def self.time_stamp
    Home.active_home.time_tag.year
  end

  def self.active_home
    Home.all.where(active: true).first || example_home # safe fallback to use so we dont error out
  end

  def self.brand
    active_home.brand_name
  end

  def self.site_width
    active_home.site_width
  end

  def self.example_home
    Home.new(about: 'Hello visitor, welcome to my website',
             site_icon_size: 3,
             site_width: 720,
             brand_name: 'personal rails website',
             time_tag: Time.now,
             icon_class: 'fa-solid', 
             icon: 'fa-robot', blogs: Blog.all)
  end
end
