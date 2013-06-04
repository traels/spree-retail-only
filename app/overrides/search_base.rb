Spree::Core::Search::Base.class_eval do
  alias_method :orig_get_products_conditions_for,  :get_products_conditions_for unless method_defined? :orig_get_products_conditions_for
  def get_products_conditions_for(base_scope, query)
  	base_scope = orig_get_products_conditions_for(base_scope, query)
    return base_scope if current_user and current_user.has_spree_role? :admin
  	if current_user and current_user.has_spree_role? :retail
  	  base_scope = base_scope.where("#{Spree::Product.quoted_table_name}.retail_only = ?", true)
  	else
  	  base_scope = base_scope.where("#{Spree::Product.quoted_table_name}.retail_only != ?", true)
    end
    base_scope
  end
end