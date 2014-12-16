FactoryGirl.define do

  factory :wheelchair do
    manufacturer "Pride"
    model_type "Stylus"
    color "Black"
    width 16
    depth 18
    inventory_tag "Pri Stylus"
    sequence(:serial_number) { |n| "Pri-#{n}" }
  end
end