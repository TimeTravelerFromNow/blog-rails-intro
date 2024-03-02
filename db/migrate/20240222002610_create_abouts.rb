class CreateAbouts < ActiveRecord::Migration[7.0]
  def change
    create_table :abouts do |t|
      t.references :blog, null: true, foreign_key: true

      t.timestamps
    end
  end
end
