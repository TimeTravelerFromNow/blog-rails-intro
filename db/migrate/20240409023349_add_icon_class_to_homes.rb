class AddIconClassToHomes < ActiveRecord::Migration[7.0]
  def change
    add_column :homes, :icon_class, :string
  end
end
