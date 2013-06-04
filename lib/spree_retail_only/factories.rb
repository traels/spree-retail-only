FactoryGirl.define do
  factory :retail_user, class: Spree.user_class do
    email { generate(:random_email) }
    login { email }
    password 'secret'
    password_confirmation { password }
    authentication_token { generate(:user_authentication_token) } if Spree.user_class.attribute_method? :authentication_token

    spree_roles { [Spree::Role.find_by_name('retail') || create(:role, name: 'retail')] }
  end
end