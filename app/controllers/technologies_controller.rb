class TechnologiesController < ApplicationController
  before_action :get_technology, only: [:edit, :update, :show, :destroy]
  
  def index 
    @technologies = Technology.all 
  end

  def new 
    @technology = Technology.new 
  end

  def create
    @technology = Technology.new(technology_params)
    if @technology.save 
      redirect_to technologies_path, notice: "Technology successfully added"
    else 
      render :new 
    end
  end

  def edit
    
  end

  def update
    if @technology.update(technology_params)
      redirect_to technologies_path, notice: 'Technology successfully updated'
    else 
      render :edit 
    end
  end

  def destroy
    if @technology.destroy
      redirect_to technologies_path, notice: 'Technology successfully deleted.'
    else 
      redirect_to technology_path(@technology), notice: 'Could not delete technology'
    end    
  end

  private 

  def technology_params 
    params.require(:technology).permit(:name, :color)
  end

  def get_technology
    @technology = Technology.find(params[:id])
  end

end
