Spree::StoreController.class_eval do
  before_filter :retail_only_order_items
  def retail_only_order_items
    return unless @current_order
    @current_order.line_items.each do |item|
      if can? :see_retail_only_products, Spree::Product
        @current_order.contents.remove(item.variant, item.quantity) unless item.variant.product.retail_only
      else
        @current_order.contents.remove(item.variant, item.quantity) if item.variant.product.retail_only
      end
    end
  end
end