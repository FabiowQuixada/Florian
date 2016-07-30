module HelperUtility
  # rubocop:disable all
  def go_back
    page.find('#form_back_btn').click
    sleep(inspection_time = 0.5)
  end
  # rubocop:enable all

  def input_blur
    page.find('body').click
  end
end

RSpec.configure do |config|
  config.include HelperUtility, type: :request
end
