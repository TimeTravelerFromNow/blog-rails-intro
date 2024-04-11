class AddSiteWidthToHomes < ActiveRecord::Migration[7.0]
  def change
    add_column :homes, :site_width, :integer, :default => 720
  end
end
