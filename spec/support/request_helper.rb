module RequestHelper

  def go_back
    page.find('#form_back_btn').click
    wait
  end

  def wait
    sleep 0.5
  end

  def input_blur
    page.find('body').click
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
end
