require 'rails_helper'

describe SystemSetting, js: true, type: :request do
  let(:re_title) { 're #competencia lalala' }
  let(:pse_title) { 'pse #competencia lalala' }

  describe 'as admin' do
    before :each do
      login_as_admin
      visit system_settings_path
    end

    it 'updates data' do
      fill_settings_fields
      click_on_update_btn
      check_if_changes_persisted
    end
  end

  describe 'as common user' do
    before :each do
      login_as_common_user
    end
  end

  # == Helper methods =============================================================
  def fill_settings_fields
    page.find('#main_tab_1_title').click
    first('#system_setting_re_title').set re_title

    page.find('#main_tab_2_title').click
    first('#system_setting_pse_title').set pse_title
  end

  def check_if_changes_persisted
    visit system_settings_path
    check_receipt_tab
    check_prod_serv_tab
  end

  def check_receipt_tab
    page.find('#main_tab_1_title').click
    expect(first('#system_setting_re_title').value).to eq re_title
  end

  def check_prod_serv_tab
    page.find('#main_tab_2_title').click
    expect(first('#system_setting_pse_title').value).to eq pse_title
  end

  after :all do
    settings = described_class.first
    settings.pse_title = I18n.t('defaults.report.product_and_service.email_title')
    settings.re_title = I18n.t('defaults.report.receipt.email_title')
    settings.save
  end
end
