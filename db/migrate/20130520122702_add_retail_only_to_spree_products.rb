class AddRetailOnlyToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :retail_only, :boolean
  end
end
