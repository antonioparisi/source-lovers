# encoding: UTF-8
class Project < ActiveRecord::Base
  validates :name, :description, :languages, :author, :presence => true

  serialize :data, ActiveRecord::Coders::Hstore
end
