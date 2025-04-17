class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show ]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find_by!(address: params[:address])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:address)
    end
end
