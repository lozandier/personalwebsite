class PersonasController < ApplicationController
  respond_to :json, :html
  before_action :get_project
  before_action :get_existing_persona, only: [:edit, :update, :show, :destroy]

  def show
    
  end

  def new 
    @persona = @project.personas.new   
  end

  def create 
    @persona = @project.personas.new(persona_params)
    if @persona.save 
      redirect_to project_path(@project), notice: 'New Project'
    else
      render :new 
    end
  end

  def edit
    # get_persona should be succesfully called 
  end

  def update 
    if @persona.update(persona_params)
      redirect_to project_persona_path(@project, @persona), notice: 'Persona successfully updated.'
    else 
      render :edit 
    end
  end

  def destroy
    if @persona.destroy
      redirect_to project_path(@project), notice: 'Persona successfully deleted.'
    else
      redirect_to project_persona_path(@project, @persona), notice: 'Persona could not be deleted.'
    end
  end



  private 

  def get_project 
    @project = Project.friendly.find(params[:project_id])
  end

  def get_existing_persona 
    @persona = @project.personas.friendly.find(params[:id])
  end

  def persona_params
    params.require(:persona).permit(:avatar, :background_image, :first_name, :last_name, :age, :occupation, :byline, :description, :state, :approve_persona, :unapprove_persona, :full_name)
  end
end
