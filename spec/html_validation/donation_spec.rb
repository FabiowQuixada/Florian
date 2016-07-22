require 'rails_helper'

describe 'bills/_form', type: :view do

  before :all do
    assign :graph_data, [] # TODO
  end

  let(:class_name) { Bill }
  
  it 'add donation to company through new donation screen' do

    model = class_name.new
    assign :model, model
    assign :list, class_name.all
    assign :notice, ''
    assign :info, ''
    assign :alert, ''

    render template: 'bills/_form', layout: "layouts/application", locals: {info: []}

    visit 'https://validator.w3.org/nu/'

    select('text input', :from => 'Check by')


    find('#inputregion #doc').set(rendered.gsub(/\"/, '\'').gsub(/\n/, '').gsub(/\t/, ''))

    click_on 'Check'
    
    expect(page).to have_content 'Document checking completed. No errors or warnings to show.'
  end

  def info
    ''
  end
end
