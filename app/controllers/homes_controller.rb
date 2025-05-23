class HomesController < ApplicationController
  before_action :set_home, only: %i[ show edit update destroy make_active ]

  # GET /homes or /homes.json
  def index
    @homes = Home.all
  end

  def make_active
    Home.all.each do |h|
      h.active = false
      h.save
    end
    @home.active = true
    @home.save
    redirect_to homes_path
  end

  def about
    @home = Home.active_home
  end

  # GET /homes/1 or /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.example_home
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes or /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to home_url(@home), notice: "Home was successfully created." }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1 or /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to edit_home_path(@home), notice: "Home was successfully updated." }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1 or /homes/1.json
  def destroy
    @home.destroy

    respond_to do |format|
      format.html { redirect_to homes_url, notice: "Home was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def home_params
      params.require(:home).permit(:about, :time_tag, :icon, :icon_class, :site_icon_size, :site_width, :brand_name)
    end
end
