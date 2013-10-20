# encoding: UTF-8
class Project < ActiveRecord::Base
  include PgSearch
  validates :name, :description, :languages, :author, :git_repo, :presence => true

  pg_search_scope :search, :against => [:name, :description, :languages, :author, :keywords], :using => {:tsearch => {:prefix => true}, :trigram => {}, dmetaphone: {}}

  def donation_packages
    JSON.parse(data['donation_packages']) if data && data['donation_packages']
  end

  ['paypal_email', 'homepage', 'license', 'version', 'documentation', 'bug'].each do |key|
    define_method(key) { get_hvalue(key) }
  end

  private

  def get_hvalue(key)
    data[key] if data && data[key]
  end
end
