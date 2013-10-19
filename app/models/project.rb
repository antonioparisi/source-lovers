# encoding: UTF-8
class Project < ActiveRecord::Base
  include PgSearch
  validates :name, :description, :languages, :author, :presence => true

  pg_search_scope :search, :against => [:name, :description, :languages, :author], :using => {:tsearch => {:prefix => true}, :trigram => {}, dmetaphone: {}}
end
