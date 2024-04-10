class Home < ApplicationRecord
  has_rich_text :about
  has_many :blogs, dependent: :nullify
  has_and_belongs_to_many :ext_links

  def self.time_stamp
    home_time = "2022"
    if Home.active_home
      home_time = Home.active_home.time_tag.year
    end
    home_time
  end

  def self.active_home
    Home.all.where(active: true).first
  end

  def icon_full
    full = ""

    if icon_class
      full << icon_class
    else
      full << "fa-brands"
    end

    if icon
      full << " " << icon
    else
      full << " " << "fa-rebel"
    end

    full
  end

  def self.icon
    if Home.active_home
      return Home.active_home.icon_full
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
end
