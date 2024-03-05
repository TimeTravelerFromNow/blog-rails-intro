module BlogsHelper
  def blog_img(blog)
    if blog.header_image.present?
      return blog.header_image
    end
    return "dipper-img.png"
  end
end
