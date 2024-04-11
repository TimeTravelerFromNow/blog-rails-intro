module IconsHelper
  include ActionView::Helpers::SanitizeHelper
  SIZE_CLASSES = {
    0 => "fa-2xs",
    1 => "fa-xs",
    2 => "fa-sm",
    3 => "",
    4 => "fa-lg",
    5 => "fa-xl",
    6 => "fa-2xl"
  }

  def html_strip(strip)
  #  puts "stripped: " << ActionView::Base.full_sanitizer.sanitize(strip)
  #  return ActionView::Base.full_sanitizer.sanitize(strip)
  end

  def icon_html(fa_class = "fa-solid", fa_icon = "fa-robot", fa_size = 3)
    size_class = SIZE_CLASSES[fa_size]
    before_safe = "<i class='#{fa_class} #{fa_icon} #{size_class}'></i>"
    before_safe
  end

end
