FactoryGirl.define do
  factory :role do
  	sequence(:name, 1) { |n| "Grupo #{n}" }
  	description 'Grupo'
  end
  
end