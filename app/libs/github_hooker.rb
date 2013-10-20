# encoding: UTF-8
class GithubHooker
  def initialize(project_name, repository_path)
    @project_name    = project_name
    @repository_path = repository_path
  end

  def start
    manifest = JSON.parse(Base64.decode64(Octokit.contents(@repository_path, :path => 'sourcelover.json').attrs[:content]))

    raise StandardError.new('An error is occurred getting MANIFEST') if manifest.nil?

    if validate(manifest)
      optional_data = get_optional_data(manifest)
      author        = process_field(manifest['author'], 'author')
      languages     = process_field(manifest['languages'], 'languages')

      if project = Project.find_by_git_repo(@repository_path)
        project.update_attributes!({:name => manifest['name'], :description => manifest['description'],
                                   :author => author, :languages => languages, :git_repo => @repository_path,
                                   :data => optional_data})
      else
        Project.create!(:name => manifest['name'], :description => manifest['description'],
                        :author => author, :languages => languages, :git_repo => @repository_path,
                        :data => optional_data)
      end
    end
  rescue Octokit::NotFound
    # If MANIFEST not exists, destroy project
    project = Project.find_by_git_repo(@repository_path)
    project.destroy if !project.nil?
  end

  private

  def validate(manifest)
    raise StandardError.new('Required fields not provided') if !required_manifest_fields(manifest)

    return true
  end

  def required_manifest_fields(manifest)
    ['name', 'description', 'version', 'author', 'languages'].each do |field|
      if manifest[field].blank?
        return false
      end
    end

    return true
  end

  def get_optional_data(manifest)
    optional_data = {}
    ['version', 'keywords', 'homepage', 'repository', 'documentation', 'bug', 'license',
     'author', 'maintainers', 'contributors', 'donation_packages', 'paypal_email'].each do |field|
      if !manifest[field].blank?
        optional_data[field] = manifest[field]
      end
    end

    optional_data
  end

  def process_field(field, field_type)
    result = case field_type.downcase
      when 'author'
        # Eg. {"name"=>"Foo Bar", "email"=>"foobar@x.com"}
        name = field.fetch('name', '')
        email = field.fetch('email', '')
        r = "#{name} <#{email}>" if !name.blank? && !email.blank?
        r = email if name.blank? && !email.blank?
        r = name if !name.blank? && email.blank?
        r
      when 'languages'
        # Eg. ["ruby", "objective-c"]
        field.join(', ')
    end

    result
  end

end
