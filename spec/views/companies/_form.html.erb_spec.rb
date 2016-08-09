require 'rails_helper'

describe 'companies/_form', type: :view do
  let(:class_name) { Company }
  it_behaves_like 'an form view'

  it 'renders partials' do
    model = class_name.new
    assign :model, model
    render

    expect(view).to render_template(partial: 'shared/error_alert', locals: { id: 'donation' })
    expect(view).to render_template(partial: 'shared/tab_commons', locals: { tab_type: 'main', number_of_tabs: 3 })
  end

  describe 'donation' do
    it 'displays a no-donation message if it is the case' do
      model = class_name.new
      assign :model, model
      render

      expect(rendered).not_to have_selector('tr#no_donations_row', visible: true)
    end

    it 'does not display a no-donation message if it has donations' do
      model = build :company, :with_donations
      assign :model, model
      render

      expect(rendered).to have_selector('tr#no_donations_row', visible: false)
    end
  end

  describe 'contact' do
    it 'displays a no-contact message if it is the case' do
      model = class_name.new
      assign :model, model
      render

      expect(rendered).not_to have_selector('tr#no_contacts_row', visible: true)
    end

    it 'does not display a no-contact message if it has contacts' do
      model = build :company, :with_contacts
      assign :model, model
      render

      expect(rendered).to have_selector('tr#no_contacts_row', visible: false)
    end
  end
end
