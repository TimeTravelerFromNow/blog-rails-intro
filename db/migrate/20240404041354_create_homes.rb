class CreateHomes < ActiveRecord::Migration[7.0]
  def change
    create_table :homes do |t|
      t.references :blogs, null: false, foreign_key: true
      t.datetime :time_tag

      t.timestamps
    end
  end
end
