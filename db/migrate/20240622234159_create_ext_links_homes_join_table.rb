class CreateExtLinksHomesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :homes, :ext_links do |t|
      t.index :home_id
      t.index :ext_link_id
    end
  end
end
