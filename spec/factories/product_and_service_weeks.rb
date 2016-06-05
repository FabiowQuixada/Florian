FactoryGirl.define do
  factory :product_and_service_week do
  	product_and_service_datum

  	transient do
  	  service_data_count 2
  	end

  	after(:build) do |product_and_service_week, evaluator|
      build_list(:service_data, evaluator.service_data_count, product_and_service_week: product_and_service_week)
      product_and_service_week.product_data ||= build(:product_data, :product_and_service_week => product_and_service_week)
    end
  end
  
end