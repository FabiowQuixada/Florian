require 'rails_helper'

describe 'Status', js: true, type: :request do
  STATUS_DATA = [Role, ReceiptEmail].freeze

  context 'admin' do
    before :each do
      login_as_admin
    end

    it "changes models' status" do
      STATUS_DATA.each do |data|
        visit send("#{data.model_name.route_key}_path")
        click_first_valid_status_btn data.new
        expect_success_msg
      end
    end
  end

  context 'common user' do
    before :each do
      login_as_common_user
    end

    it "change models' status" do
      [ReceiptEmail].each do |data|
        toogle_status_of data.new
        expect_success_msg
      end
    end

    it 'does not change private area' do
      [User, Role].each do |data|
        visit send("#{data.model_name.route_key}_path")
        expect_access_denied_msg
      end
    end
  end

  # == Helper methods =============================================================

  def click_first_valid_status_btn(model)
    return unless page.has_css?('.model_row')

    if model.is_a? User
      handle_user_model
    else
      all('.model_row').first.all('.status_btn')[0].click
    end
  end

  def handle_user_model
    page.all('.model_row').each do |row|
      email = row.find('.user_email').text
      if email != SYSTEM_EMAIL && email != 'teste_comum@yahoo.com.br'
        row.find('.status_btn').click
        break
      end
    end
  end

  def toogle_status_of(model)
    visit send("#{model.model_name.route_key}_path")

    return unless page.has_css?('.model_row')

    all('.model_row').first.all('.status_btn')[0].click
  end
end
