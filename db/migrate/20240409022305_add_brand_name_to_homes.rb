class AddBrandNameToHomes < ActiveRecord::Migration[7.0]
  def change
    add_column :homes, :brand_name, :string
  end
end
