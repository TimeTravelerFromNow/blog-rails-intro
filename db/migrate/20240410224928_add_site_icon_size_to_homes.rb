class AddSiteIconSizeToHomes < ActiveRecord::Migration[7.0]
  def change
    add_column :homes, :site_icon_size, :integer
  end
end
