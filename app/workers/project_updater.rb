class ProjectUpdater
  include Sidekiq::Worker

  def perform(name, description, author, version, data)
    if project = Project.find_by_name(name)
      project.update_attributes({:name => name, :description => description, :author => author, :version => version,
                                 :data => data})
    else
      Project.create!(:name => name, :description => description, :author => author, :version => version,
                      :data => data)
    end
  end

end