class ProjectUpdater
  include Sidekiq::Worker

  def perform(project_name, repository_path)
    GithubHooker.new(project_name, repository_path).start
  end

end