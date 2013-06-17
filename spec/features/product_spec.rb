require 'spec_helper'

describe "Spree::Product" do
  describe "admin interface" do
  	it "should have a retail_only checkbox on product page" do
      product = create(:product)
      user = create(:admin_user, :email => "admin@person.com", :password => "password", :password_confirmation => "password")
      sign_in_admin!(user)
      visit "/admin/products"
      within('table.index') { click_link "Edit" }
      check('Only for retail')
      click_button "Update"
      page.should have_content("successfully updated!")
      page.has_checked_field?('product_retail_only').should == true
  	end
  end

  describe "none retail user" do
    it "should not see retail products" do
      product1 = create(:product, :retail_only => true)
      product2 = create(:product, :retail_only => false)
      user = create(:user, :email => "user@person.com", :password => "secret", :password_confirmation => "secret")
      sign_in_as!(user)
      page.all('li[@data-hook="products_list_item"]').count.should == 1
      page.should have_content(product2.name)
    end
  end

  describe "retail user" do
    it "should only see retail products in list" do
      product1 = create(:product, :retail_only => true)
      product2 = create(:product, :retail_only => false)
      user = create(:retail_user, :email => "user@person.com", :password => "secret", :password_confirmation => "secret")
      sign_in_as!(user)
      page.all('li[@data-hook="products_list_item"]').count.should == 1
      page.should have_content(product1.name)
    end

    it "should only see retail products in taxon product list" do      
      taxonomy = create(:taxonomy)
      root_taxon = taxonomy.root
      child_taxon = create(:taxon, :taxonomy_id => taxonomy.id, :parent => root_taxon)
      child_taxon2 = create(:taxon, :taxonomy_id => taxonomy.id, :parent => root_taxon)

      product1 = create(:product, :retail_only => true)
      product1.taxons = [child_taxon]
      product1.save
      product11 = create(:product, :retail_only => true)
      product11.taxons = [child_taxon,child_taxon2]
      product11.save

      product2 = create(:product, :retail_only => false)
      product2.taxons = [child_taxon]
      product2.save
      product21 = create(:product, :retail_only => false)
      product21.taxons = [child_taxon,child_taxon2]
      product21.save

      user = create(:retail_user, :email => "user@person.com", :password => "secret", :password_confirmation => "secret")
      sign_in_as!(user)
      visit "/t/#{root_taxon.permalink}"
#      page.all('li[@data-hook="products_list_item"]').count.should == 1 # product is listed twice due to current Spree shop setup
      page.should have_content(product1.name)
      page.should have_content(product11.name)
      page.should_not have_content(product2.name)
      page.should_not have_content(product21.name)
    end

    it "should be able to see retail-only productcard" do
      retail = create(:product, :retail_only => true)
      non_retail = create(:product, :retail_only => false)
      user = create(:retail_user, :email => "user@person.com", :password => "secret", :password_confirmation => "secret")
      sign_in_as!(user)
      visit "/products/#{retail.permalink}"
      page.status_code.should == 200
    end

    it "should have non-retail products stripped from basket upon login" do
      retail = create(:product, :retail_only => true)
      non_retail = create(:product, :retail_only => false)
      user = create(:retail_user, :email => "user@person.com", :password => "secret", :password_confirmation => "secret")
      visit "/products/#{non_retail.permalink}"
      click_button('Add To Cart')
      sign_in_as!(user)
      visit "/cart"
      page.all('tr[@class=" line-item"]').count.should == 0
    end
  end

end