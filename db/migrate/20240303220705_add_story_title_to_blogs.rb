class AddStoryTitleToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :story_title, :string, :default => "About"
  end
end
