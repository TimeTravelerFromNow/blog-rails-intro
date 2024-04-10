class CreateExtLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :ext_links do |t|
      t.string :link
      t.string :fa_class
      t.string :fa_icon

      t.timestamps
    end
  end
end
