class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:edit, :update, :destroy]

  layout 'signed_in'

  def index
    @projects = Project.order(created_at: :asc)
    @project = Project.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.creator = current_user if respond_to?(:current_user) && current_user

    if @project.save
      redirect_to projects_path, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end

