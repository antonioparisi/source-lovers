# encoding: UTF-8
class Project < ActiveRecord::Base
  include PgSearch
  validates :name, :description, :languages, :author, :git_repo, :presence => true

  pg_search_scope :search, :against => [:name, :description, :languages, :author, :keywords], :using => {:tsearch => {:prefix => true}, :trigram => {}, dmetaphone: {}}

  def donation_packages
    JSON.parse(data['donation_packages']) if data && data['donation_packages']
  end

  def paypal_email
    data['paypal_email'] if data && data['paypal_email']
  end
end
