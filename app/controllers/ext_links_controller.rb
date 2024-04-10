class ExtLinksController < ApplicationController
  before_action :set_ext_link, only: %i[ show edit update destroy ]

  # GET /ext_links or /ext_links.json
  def index
    @ext_links = ExtLink.all
  end

  # GET /ext_links/1 or /ext_links/1.json
  def show
  end

  # GET /ext_links/new
  def new
    @ext_link = ExtLink.new
  end

  # GET /ext_links/1/edit
  def edit
  end

  # POST /ext_links or /ext_links.json
  def create
    @ext_link = ExtLink.new(ext_link_params)

    respond_to do |format|
      if @ext_link.save
        format.html { redirect_to ext_link_url(@ext_link), notice: "Ext link was successfully created." }
        format.json { render :show, status: :created, location: @ext_link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ext_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ext_links/1 or /ext_links/1.json
  def update
    respond_to do |format|
      if @ext_link.update(ext_link_params)
        format.html { redirect_to ext_link_url(@ext_link), notice: "Ext link was successfully updated." }
        format.json { render :show, status: :ok, location: @ext_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ext_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ext_links/1 or /ext_links/1.json
  def destroy
    @ext_link.destroy

    respond_to do |format|
      format.html { redirect_to ext_links_url, notice: "Ext link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ext_link
      @ext_link = ExtLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ext_link_params
      params.require(:ext_link).permit(:link, :fa_class, :fa_icon)
    end
end
