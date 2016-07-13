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
    # expect(view).to render_template(partial: "shared/form_buttons", locals: {model: @model, f: f})
  end

  describe 'donation' do
    it 'displays a no-donation message if it is the case' do
      model = class_name.new
      assign :model, model
      render

      expect(rendered).to include genderize_tag(Donation.new, 'helpers.none_registered')
    end

    it 'does not display a no-donation message if it has donations' do
      model = build :company, :with_donations
      assign :model, model
      render

      expect(rendered).not_to include genderize_tag(Donation.new, 'helpers.none_registered')
    end
  end

  describe 'contact' do
    it 'displays a no-contact message if it is the case' do
      model = class_name.new
      assign :model, model
      render

      expect(rendered).to include genderize_tag(Contact.new, 'helpers.none_registered')
    end

    it 'does not display a no-contact message if it has contacts' do
      model = build :company, :with_contacts
      assign :model, model
      render

      expect(rendered).not_to include genderize_tag(Contact.new, 'helpers.none_registered')
    end
  end
end
