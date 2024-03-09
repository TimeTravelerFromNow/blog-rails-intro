class ContentsController < ApplicationController
  before_action :set_post
  before_action :build_content, only: %i[create]
  before_action :set_content, only: %i[update destroy]
  def create
    respond_to do |format|
      if @content.save
        format.html { redirect_to edit_post_url(@post), notice: "content was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to edit_post_url(@post), notice: "content was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to edit_post_url(@post), notice: "content was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_content
    @content = Content.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def build_content
    @content = @post.contents.build(content_params)
  end

  def content_params
    params.require(:content).permit(:post_id, :kind, :txt, :img)
  end
end
