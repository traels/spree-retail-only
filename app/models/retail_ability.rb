class RetailAbility
    include CanCan::Ability 
    
    def initialize(user)
      user ||= User.new
      cannot :see_retail_only_products, Spree::Product
      if user.has_spree_role? "retail"
        can :see_retail_only_products, Spree::Product
      end
    end
end