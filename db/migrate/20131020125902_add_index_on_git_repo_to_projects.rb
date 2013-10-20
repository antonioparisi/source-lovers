class AddIndexOnGitRepoToProjects < ActiveRecord::Migration
  def change
    add_index :projects, :git_repo, :unique => true
  end
end
