# encoding: UTF-8
class HooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:github, :stripe]

  def github
    github_payload  = JSON.parse(params[:payload])
    project_name    = github_payload['repository']['name']

    raise StandardError.new('Project name is required') if project_name.nil?
    repository_path = github_payload['repository']['owner']['name'] + '/' + github_payload['repository']['name']

    ProjectUpdater.perform_async(project_name, repository_path)

    render json: { success: :true }, status: 200
  rescue => error
    render json: { error: error.message }, status: 400
  end

end
