Deface::Override.new(:virtual_path  => "spree/admin/products/_form",
                     :insert_before => "ul#shipping_specs",
                     :text          => " <div class='field'>
        								<%= f.check_box :retail_only, :style => 'width:auto;' %>
        								<%= f.label :retail_only, Spree.t(:retail_only) %>
      									</div>",
                     :name          => "products_retail_only")