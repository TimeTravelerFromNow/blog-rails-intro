class ContentsController < ApplicationController
  before_action :set_post
  before_action :set_content, only: %i[update destroy]

  def create
    @content = @post.contents.build(content_params)
    @content.save
    redirect_to edit_post_path @post
  end

  def update
    @content.update(content_params)
    redirect_to edit_post_path @post
  end

  def destroy
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  # Only allow a list of trusted parameters through.
  def content_params
    params.require(:content).permit(:image, :kind, :paragraph, :position)
  end

  def set_content
    @content = Content.find(params[:id])
  end
end
