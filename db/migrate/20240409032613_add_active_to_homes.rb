class AddActiveToHomes < ActiveRecord::Migration[7.0]
  def change
    add_column :homes, :active, :boolean
  end
end
