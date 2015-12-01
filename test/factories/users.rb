FactoryGirl.define do
  factory :user do
    email { "ftquixada@gmail.com"}
    password "fulano0123"
    password_confirmation "fulano0123"
    #confirmed_at Date.today
  end
end