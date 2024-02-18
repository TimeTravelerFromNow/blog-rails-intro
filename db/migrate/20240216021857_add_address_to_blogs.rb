class AddAddressToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :address, :string
  end
end
