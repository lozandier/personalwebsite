class PhotosController < ApplicationController
  before_action :get_project
  before_action :get_existing_photo, only: [:edit, :update, :destroy]

  def index
    @photos = @project.photos 
  end

  def show
    @photo = @project.photos.find(params[:id])
  end

  def new 
    @photo = @project.photos.new 
  end

  def create
    @photo = @project.photos.new(photo_params)
    if @photo.save 
      redirect_to project_path(@project), notice: 'Photo successfully saved'
    else 
      render :new 
    end
  end

  def edit
  end

  def update 
    if @photo.update 
      redirect_to project_path(@project), notice: 'Project successfuly added'
    else
      render :edit 
    end
  end

  def destroy
    @photo.destroy 
    redirect_to project_path(@project), notice: "Photo successfully deleted"
  end

  private 

  def get_project
    @project = Project.friendly.find(params[:project_id])
  end

  def get_existing_photo
    @photo = Project.photos.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end

  

end
