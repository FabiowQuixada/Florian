require 'rails_helper'

describe 'Unsaved data', js: true, type: :request do
  UNSAVED_DATA = [Maintainer, Bill, ProductAndServiceDatum, Donation, ReceiptEmail].freeze

  before :each do
    login_as_admin
  end

  it 'displays unsaved data warning' do
    UNSAVED_DATA.each do |data|
      fill_non_temp_data data.new
      go_back
      expect(page).to have_content('Dados não salvos'), data.name
    end
  end

  it 'does not display unsaved data warning if temporary fields are filled' do
    [Maintainer, Bill, ProductAndServiceDatum, Donation, ReceiptEmail].each do |data|
      fill_temp_data data.new
      go_back
      expect(page).to have_no_content('Dados não salvos'), data.name
    end
  end

  it 'displays unsaved data warning also for status change' do
    [ReceiptEmail, User, Role].each do |data|
      change_status_and_go_back data
    end
  end

  # == Helper methods =============================================================

  def change_status_and_go_back(data)
    visit send('edit_' + data.name.underscore + '_path', data.first)

    first('.form_status_box img').click

    go_back
    expect(page).to have_content('Dados não salvos'), data.name
  end

  def fill_temp_data(model)
    visit edit_path(model)
    go_somewhere_with_a_temp_field model

    fill_temp_inputs unless all('.temp_field').empty?
  rescue Capybara::ElementNotFound => e
    raise Capybara::ElementNotFound, e.message + ': ' + model.class.name
  end

  def fill_non_temp_data(model)
    visit edit_path(model)
    fill_non_temp_inputs
  rescue Capybara::ElementNotFound => e
    raise Capybara::ElementNotFound, e.message + ': ' + model.class.name
  end

  def go_somewhere_with_a_temp_field(model)
    page.find('#main_tab_1_title').click if model.is_a? Maintainer
  end

  def edit_path(model)
    send('edit_' + model.class.name.singularize.underscore + '_path', model.class.first.id)
  end

  def fill_temp_inputs
    field = first('.temp_field:not([readonly])')
    field.set 'whatever' unless field.nil?
  end

  def fill_non_temp_inputs
    fill_a_non_temp_input
    fill_a_non_temp_number
    fill_a_non_temp_textarea
    fill_a_non_temp_date
    fill_a_non_temp_money_input
  end

  def fill_a_non_temp_input
    field = first('input:not([readonly])')
    field.set 'whatever' unless field.nil?
  end

  def fill_a_non_temp_number
    field = first('.numbers_only:not([readonly])')
    field.set '4' unless field.nil?
  end

  def fill_a_non_temp_textarea
    field = first('textarea:not([readonly])')
    field.set 'whatever' unless field.nil?
  end

  def fill_a_non_temp_date
    field = first('.date:not([readonly])')
    field.set '11/11/1111' unless field.nil?
  end

  def fill_a_non_temp_money_input
    field = first('.money:not([readonly])')
    field.set '0,01' unless field.nil?
  end
end
