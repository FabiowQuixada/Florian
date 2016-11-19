require 'factory_girl_rails'

if Rails.env.showcase?
  guest_role = Role.create name: SHOWCASE_USER, description: SHOWCASE_USER

  GUEST_USERS_NUMBERS.each do |number|
    User.create name: "Guest#{number}",
                email: "guest_#{number}@florian.com",
                password: SHOWCASE_PASSWORD,
                password_confirmation: SHOWCASE_PASSWORD,
                role: guest_role
  end
end


if Rails.env.production?
  # These files are not to be commited to any repository
  Rake::Task['db:load_production_data'].invoke
  ExcelParser.parse
else
  30.times { FactoryGirl.create :maintainer }
  50.times { FactoryGirl.create :donation }
  30.times { FactoryGirl.create :receipt_email, :showcase }

  (0..6).each { |m| FactoryGirl.create :product_and_service_datum, :populated, competence: Date.today - m.months }
  (0..50).each { |m| FactoryGirl.create :bill, competence: Date.today - m.months }
end
