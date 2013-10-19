class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text   :description
      t.string :languages
      t.string :author
      t.hstore :data

      t.timestamps
    end

    add_hstore_index :projects, :data
  end
end
