class Admin::DashboardController < AdminController

  def index
    @blogs = Blog.all
    @posts = Post.all
    @contents = Content.all
  end

end
