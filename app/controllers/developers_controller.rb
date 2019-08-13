class DevelopersController < ApplicationController
  before_action :authenticate_admin
  before_action :set_developer, only: [:show, :edit, :update, :destroy]

  # GET /developers
  # GET /developers.json
  def index
    @developers = Developer.all
  end

  # GET /developers/1
  # GET /developers/1.json
  def show
  end

  # GET /developers/new
  def new
    @developer = Developer.new
  end

  # GET /developers/1/edit
  def edit
  end

  # POST /developers
  # POST /developers.json
  def create
    @developer = Developer.new(developer_params)
    if @developer.save
      @developers = Developer.all
    end
  end

  # PATCH/PUT /developers/1
  # PATCH/PUT /developers/1.json
  def update
    modified_params = developer_params
    modified_params.delete("password") if modified_params["password"].empty?
    if @developer.update(modified_params)
      @developers = Developer.all
    end
  end

  # DELETE /developers/1
  # DELETE /developers/1.json
  def destroy
    @developer.destroy
    respond_to do |format|
      format.html { redirect_to developers_url, notice: 'Developer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_developer
    @developer = Developer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def developer_params
    params.require(:developer).permit(:name, :email, :password)
  end
end
