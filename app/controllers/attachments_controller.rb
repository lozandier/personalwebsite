class AttachmentsController  < ApplicationController 
  before_action :get_project 
  before_action :get_existing_attachment, only: [:edit, :update, :delete]

  def new  
    @attachment = @project.attachments.new 
  end

  def create 
    @attachment = @project.attachments.new(attachment_params)
    if @attachment.save 
      redirect_to project_path(@project), notice: "Attachment Successfully Added"
    else render :new 
    end 
  end

  def edit 
    
  end
  
  def delete 
    if @attachment.destroy 
      redirect_to project_path(@project), notice: 'Attachment Successfully Added'
    else 
      redirect_to project_path(@project), notice: 'Attachment Successfully Added'
    end
  end

  protected 

  def get_project
    @project = Project.friendly.find(params[:project_id])
  end

  def attachment_params
    params.require(:attachment).permit(:file, :name, :description)
  end

  def get_existing_attachment 
    @project.attachments.friendly.find(params)
  end

end
