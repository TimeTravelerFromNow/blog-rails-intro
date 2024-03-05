class AddBlogToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :blog, null: true, foreign_key: true
  end
end
