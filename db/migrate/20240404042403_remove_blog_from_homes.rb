class RemoveBlogFromHomes < ActiveRecord::Migration[7.0]
  def change
    remove_reference :homes, :blogs, null: false, foreign_key: true
  end
end
