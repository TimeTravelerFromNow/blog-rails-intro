class AddExtLinksToHomes < ActiveRecord::Migration[7.0]
  def change
    create_table :homes_ext_links, id: false do |t|
      t.belongs_to :homes
      t.belongs_to :ext_links
    end
  end
end
