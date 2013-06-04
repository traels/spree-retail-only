require 'spec_helper'

describe "Spree::Product" do
  describe "Add retail_only flag" do
	it "should accept creating a product with retail_only flag" do
      FactoryGirl.build(:product, :retail_only => true).should be_valid
    end
  end
end