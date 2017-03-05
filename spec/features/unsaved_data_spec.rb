require 'rails_helper'

describe 'Unsaved data', js: true, type: :request do
  UNSAVED_DATA = [Maintainer, Bill, ProductAndServiceDatum, Donation, ReceiptEmail].freeze

  before :each do
    login_as_admin
  end

  it 'warning is displayed' do
    UNSAVED_DATA.each do |data|
      fill_non_temp_data data.new
      go_back
      expect(page).to have_content(I18n.t('modal.title.back')), data.name
    end
  end

  it 'is not displayed if only temporary fields are filled' do
    UNSAVED_DATA.each do |data|
      visit edit_path data.first
      go_back
      # expect(page).not_to have_content(I18n.t('modal.title.back')), data.name
    end
  end

  it 'is displayed if status changes' do
    [ReceiptEmail, User, Role].each do |data|
      change_status_and_go_back data
    end
  end

  # == Helper methods =============================================================

  def change_status_and_go_back(data)
    visit send("edit_#{data.name.underscore}_path", data.first)

    first('.form_status_box img').click

    go_back
    expect(page).to have_content I18n.t('modal.title.back')
  end

  def fill_temp_data(model)

    # go_somewhere_with_a_temp_field model

    # fill_temp_inputs unless all('.temp_field').empty?
  rescue Capybara::ElementNotFound => e
    raise Capybara::ElementNotFound, "#{e.message}: #{model.class.name}"
  end

  def fill_non_temp_data(model)
    visit edit_path(model)
    fill_non_temp_inputs
  rescue Capybara::ElementNotFound => e
    raise Capybara::ElementNotFound, "#{e.message}: #{model.class.name}"
  end

  def go_somewhere_with_a_temp_field(model)
    page.find('#main_tab_1_title').click if model.is_a? Maintainer
  end

  def edit_path(model)
    send("edit_#{model.class.name.singularize.underscore}_path", model.class.first.id)
  end

  def fill_temp_inputs
    # fill_text_input true
    # fill_number_input true
    # fill_textarea true
    # fill_date_input true
    # fill_money_input true
  end

  def fill_non_temp_inputs
    fill_text_input false
    fill_number_input false
    fill_textarea false
    fill_date_input false
    fill_money_input false
  end

  def fill_text_input(temp_field)
    temp_class = temp_css_class temp_field
    field = first("input[type='text']:not([readonly]):not(.date):not(.money):not(.numbers_only)#{temp_class}")
    field.set Faker::Lorem.word unless field.nil?
  end

  def fill_number_input(temp_field)
    temp_class = temp_css_class temp_field
    field = first("input[type='text'].numbers_only:not([readonly])#{temp_class}")
    field.set '4' unless field.nil?
  end

  def fill_textarea(temp_field)
    temp_class = temp_css_class temp_field
    field = first("textarea:not([readonly])#{temp_class}")
    field.set Faker::Lorem.word unless field.nil?
  end

  def fill_date_input(temp_field)
    temp_class = temp_css_class temp_field
    field = first("input[type='text'].date:not([readonly])#{temp_class}")
    field.set I18n.localize(Faker::Date.forward(23)) unless field.nil?
    execute_script('$(".datepicker-dropdown").hide()')
  end

  def fill_money_input(temp_field)
    temp_class = temp_css_class temp_field
    field = first("input[type='text'].money:not([readonly])#{temp_class}")
    field.set Faker::Number.number(4) unless field.nil?
  end

  def temp_css_class(temp_field)
    temp_field ? '.temp_field' : ':not(.temp_field)'
  end
end
