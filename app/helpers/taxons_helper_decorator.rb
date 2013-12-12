Spree::TaxonsHelper.class_eval do
  alias_method :orig_taxon_preview,  :taxon_preview unless method_defined? :orig_taxon_preview

  def taxon_preview(taxon, max=4)
#    products = orig_taxon_preview(taxon,max)

    products = taxon.active_products

    return products.limit(max).uniq if spree_current_user and spree_current_user.has_spree_role? :admin
    if spree_current_user and spree_current_user.has_spree_role? :retail
      products = products.where("#{Spree::Product.quoted_table_name}.retail_only = ?", true).references("#{Spree::Product.quoted_table_name}")
    else
      products = products.where("#{Spree::Product.quoted_table_name}.retail_only != ?", true).references("#{Spree::Product.quoted_table_name}")
    end
    products.limit(max)


#    if (products.size < max) && Spree::Config[:show_descendents]
#      taxon.descendants.each do |taxon|
#        to_get = max - products.length
#        subproducts = taxon.active_products
#        if spree_current_user and spree_current_user.has_spree_role? :retail
#          subproducts = subproducts.where("#{Spree::Product.quoted_table_name}.retail_only = ?", true).references("#{Spree::Product.quoted_table_name}")
#        else
#          subproducts = subproducts.where("#{Spree::Product.quoted_table_name}.retail_only != ?", true).references("#{Spree::Product.quoted_table_name}")
#        end
#        products += subproducts.limit(to_get)
#        products = products.uniq
#        break if products.size >= max
#      end
#    end

    products
 end
end