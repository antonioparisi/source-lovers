class AddSearchFeatures < ActiveRecord::Migration
  def self.up
    execute 'create extension if not exists pg_trgm'
    execute 'create extension if not exists fuzzystrmatch'
  end

  def self.down
    execute 'drop extension pg_trgm'
    execute 'drop extension fuzzystrmatch'
  end
end
