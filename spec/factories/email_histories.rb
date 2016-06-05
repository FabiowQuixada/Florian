FactoryGirl.define do
  factory :email_history do
  	value 3
  	body SSETTINGS_RE_BODY
  	send_type EmailHistory.send_types[:auto]
  	recipients_array Faker::Internet.email
  	user
  	receipt_email
  end
  
end