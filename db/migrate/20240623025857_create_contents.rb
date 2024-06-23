class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :kind
      t.integer :position
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
