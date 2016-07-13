require 'rails_helper'

describe 'Unsaved data', type: :request do
  UNSAVED_DATA = [Company, Bill, ProductAndServiceDatum, Donation, Role, User, ReceiptEmail].freeze

  it 'displays unsaved data warning' do
    login_as_admin

    UNSAVED_DATA.each do |data|
      fill_non_temp_data_and_return data.new
      expect(page).to have_content('Dados não salvos'), data.name
    end
  end

  it 'does not display unsaved data warning if temporary fields are filled' do
    login_as_admin

    [Company, Bill, ProductAndServiceDatum, Donation, ReceiptEmail].each do |data|
      fill_temp_data_and_return data.new
      expect(page).to have_no_content('Dados não salvos'), data.name
    end
  end

  # == Helper methods =============================================================

  def fill_temp_data_and_return(model)

    visit edit_path(model)

    go_somewhere_with_a_temp_field model

    unless all('.temp_field').empty?
      fill_temp_inputs
      go_back
    end
  rescue Capybara::ElementNotFound => e
    raise Capybara::ElementNotFound, e.message + ': ' + model.class.name
  end

  def go_somewhere_with_a_temp_field(model)
    page.find('#main_tab_1_title').click if model.is_a? Company
  end

  def fill_non_temp_data_and_return(model)
    visit edit_path(model)
    fill_all_non_temp_inputs
    go_back
  rescue Capybara::ElementNotFound => e
    raise Capybara::ElementNotFound, e.message + ': ' + model.class.name
  end

  def edit_path(model)
    send('edit_' + model.class.name.singularize.underscore + '_path', model.class.first.id)
  end

  def fill_temp_inputs
    all('.temp_field').each do |input|
      input.set 'whatever' unless input[:readonly]
    end
  end

  def fill_all_non_temp_inputs
    fill_non_temp_inputs
    fill_non_temp_textareas
    fill_non_temp_dates
    fill_non_temp_money_inputs
  end

  def fill_non_temp_inputs
    all('input').each do |input|
      unless input[:readonly]
        input.set 'whatever'
        break
      end
    end
  end


  def fill_non_temp_textareas
    all('textarea').each do |textarea|
      unless textarea[:readonly]
        textarea.set 'whatever'
        break
      end
    end
  end

  def fill_non_temp_dates
    all('.date input').each do |date_field|
      unless date_field[:readonly]
        date_field.set '11/11/1111'
        break
      end
    end
  end

  def fill_non_temp_money_inputs
    all('.money').each do |money_field|
      unless money_field[:readonly]
        money_field.set '0,01'
        break
      end
    end
  end
end
