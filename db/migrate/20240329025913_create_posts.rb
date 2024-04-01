class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :status
      t.references :blog, null: true, foreign_key: true

      t.timestamps
    end
  end
end
