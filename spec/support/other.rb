module HelperUtility
  def go_back
    page.find('#form_back_btn').click
    sleep(inspection_time = 0.5)
  end
end

RSpec.configure do |config|
  config.include HelperUtility, type: :request
end
