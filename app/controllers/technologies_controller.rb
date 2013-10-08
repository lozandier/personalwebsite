class TechnologiesController < ApplicationController
  before_action :get_technology, only: [:edit, :update, :show, :destroy]
  
  def index 
    @technologies = Technology.all.decorate
  end

  def show
    @technology = TechnologyDecorator.new(@technology)
    @related_projects = @technology.projects 
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
    params.require(:technology).permit(:name, :color, :image, :byline,  :personal_history, :years_of_experience)
  end

  def get_technology
    @technology = Technology.includes(:projects, :technology_profiles).friendly.find(params[:id])
  end

end
