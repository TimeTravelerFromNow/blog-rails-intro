class AddIconToHomes < ActiveRecord::Migration[7.0]
  def change
    add_column :homes, :icon, :string
  end
end
