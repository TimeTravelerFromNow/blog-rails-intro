class AddHomesToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :blogs, :home, null: true, foreign_key: true, default: nil
  end
end
