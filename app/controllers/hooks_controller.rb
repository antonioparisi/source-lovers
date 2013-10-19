# encoding: UTF-8
class HooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:github, :stripe]

  def github
    github_payload  = JSON.parse(params[:payload])
    project_name    = github_payload['repository']['name']
    repository_path = github_payload['repository']['owner']['name'] + '/' + github_payload['repository']['name']
    modified_files  = github_payload['head_commit']['added']
    GithubHooker.new(project_name, repository_path, modified_files).start

    render json: { success: :true }, status: 200
  rescue Octokit::NotFound
    # If MANIFEST not exists, destroy project
    project = Project.find_by_name(project_name)
    project.destroy if !project.nil?

    render json: { error: 'MANIFEST not found'}, status: 400
  rescue => error
    render json: { error: error.message }, status: 400
  end

end
