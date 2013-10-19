# encoding: UTF-8
class GithubHooker
  def initialize(project_name, repository_path, modified_files)
    @project_name    = project_name
    @repository_path = repository_path
    @modified_files  = modified_files
  end

  def start
    raise StandardError.new('Project already exists') if !Project.find_by_name(@project_name).nil?
    manifest = JSON.parse(Base64.decode64(Octokit.contents(@repository_path, :path => 'MANIFEST').attrs[:content]))

    if validate(manifest)
      ProjectUpdater.perform_async(:name => manifest['name'], :description => manifest['descrition'], :author => manifest['author'],
                                   :version => manifest['version'], :data => manifest['data'])
    end
  end

  private

  def validate(manifest)
    raise StandardError.new('Required fields not provided') if !required_manifest_fields(manifest)

    return true
  end

  def required_manifest_fields(data)
    ['name', 'description', 'version'].each do |field|
      if data[field].blank?
        return false
      end
    end

    return true
  end
end
