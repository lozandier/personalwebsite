class PersonasController < ApplicationController
  respond_to :json, :html
  before_action :get_project, except: [:new, :edit]
  before_action :get_existing_persona, only: [:edit, :update, :show, :destroy]

  def index
    @personas = @project.personas
  end

  def show
    respond_with @persona
  end

  def new 
    if params[:project_id]
      get_project
      @persona = @project.personas.new
    else     
      @persona = Persona.new
    end   
  end

  def create 
    @persona = @project.personas.new(persona_params)
    if @persona.save 
      redirect_to project_path(@project), notice: 'New Persona Succesfully Saved'
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
    if params[:project_id] #if this was called in the context of an existing project... 
      @project = Project.friendly.find(params[:project_id])
    else 
      @project = Project.friendly.find(params[:persona][:project_id])
    # else
    #   @persona = Persona.friendly.find(params[:persona][:id])
    #   @project = Project.friendly.find(@persona.project.id) 
    end
  end

  def get_existing_persona 
    if params[:project_id]
      get_project
      @persona = @project.personas.friendly.find(params[:id])
    else 
      @persona = Persona.friendly.find(params[:id])
    end
  end

  def persona_params
    params.require(:persona).permit(:avatar, :background_image, :first_name, :last_name, :age, :occupation, :byline, :description, :state, :approve_persona, :unapprove_persona, :creative_commons_attribution, :creative_commons_attribution_link, :creative_commons_license, :persona_id)
  end
end
