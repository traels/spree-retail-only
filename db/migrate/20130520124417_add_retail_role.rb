class AddRetailRole < ActiveRecord::Migration
  def up
  	retail = Spree::Role.where(:name => 'retail').first
  	unless retail
  		retail = Spree::Role.new
  		retail.name = 'retail'
  		retail.save
  	end
  end
  
  def down
  end
end
