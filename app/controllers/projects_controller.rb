class ProjectsController < ApplicationController
  before_action :set_project, only: [:show]

  # GET /projects
  def index
    @projects = params[:q] ? Project.search(params[:q]) : Project
    @projects = @projects.page((params[:page] || 1).to_i)
  end

  # GET /projects/1
  def show
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end
end
