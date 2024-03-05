class AddFeaturedToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :featured, :boolean, :default => false
  end
end
