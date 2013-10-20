class ProjectsController < ApplicationController
  def index
    @projects = params[:q] ? Project.search(params[:q]) : Project
    @projects = @projects.page((params[:page] || 1).to_i)
  end

  def show
    @project = Project.find_by_git_repo("#{params[:author]}/#{params[:project_name]}")
  end

  def projects_author
  end
end
