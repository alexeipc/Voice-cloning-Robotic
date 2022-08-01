lass Admin::dashboard_controller < ApplicationController
    before_action :set_car, only: [:show, :edit, :update, :destroy]
    before_action :check_if_admin
  
    def index
      @dashboards = dashboard.all
    end
  
    def new
  
    end
  
    def new
      @dashboard = dashboard.new
    end
  
    def edit
    end
  
    def create
      @dashboard = dashboard.new(dashboard_params)
  
      respond_to do |format|
        if @dashboard.save
          format.html { redirect_to @dashboard, notice: 'dashboard was successfully created.' }
          format.json { render :show, status: :created, location: @dashboard }
        else
          format.html { render :new }
          format.json { render json: @dashboard.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      respond_to do |format|
        if @dashboard.update(dashboard_params)
          format.html { redirect_to @dashboard, notice: 'dashboard was successfully updated.' }
          format.json { render :show, status: :ok, location: @dashboard }
        else
          format.html { render :edit }
          format.json { render json: @dashboard.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @dashboard.destroy
      respond_to do |format|
        format.html { redirect_to dashboards_url, notice: 'dashboard was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
  
    def check_if_admin
      redirect_to root_path unless current_user.is_admin?
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = dashboard.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def dashboard_params
      params.require(:dashboard).permit(:make, :model, :year)
    end
  end