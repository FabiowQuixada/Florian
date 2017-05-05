require 'rails_helper'

describe 'Filter Panel', js: true, type: :request do
  before :each do
    login_as_admin
    visit maintainers_path
  end

  it 'is collapsed by default' do
    expect(page).to have_selector '.clean_filters_btn', visible: false
  end

  it 'expands if it`s clicked' do
    find('#search_form .panel-title a').click
    expect(page).to have_selector '.clean_filters_btn', visible: true
  end

  it 'defaults to expanded if at least one field is filled' do
    find('#search_form .panel-title a').click
    fill_in 'q_name_cont', with: 'some name'
    find('#search_form .filter_btn').click
    expect(page).to have_selector '.clean_filters_btn', visible: true
  end
end
