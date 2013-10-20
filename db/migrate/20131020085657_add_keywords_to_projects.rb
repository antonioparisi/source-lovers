class AddKeywordsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :keywords, :text
  end
end
