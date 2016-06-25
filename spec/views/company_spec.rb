require 'rails_helper'

class_name = Company

describe 'companies/index', type: :view do
  it 'renders index page when list is not empty' do
    model = class_name.new
    create :company
    assign :model, model
    assign :list, class_name.all

    render

    # Partials
    expect(view).to render_template(partial: 'shared/index_commons', locals: { model: model })

    # Others
    expect(rendered).to include 'class="table table-striped table-hover table-bordered table-condensed tablesorter tablesorter-blue"'
    expect(rendered).to include '<tr id="model_'
    expect(rendered).to include '<td class="model_id admin-only">'
    expect(rendered).to include '<thead>'
    expect(rendered).to include '<tbody>'
  end

  it 'renders index page when list is empty' do
    model = class_name.new
    assign :model, model
    assign :list, []

    render

    # Partials
    expect(view).to render_template(partial: 'shared/index_commons', locals: { model: model })

    # Others
    expect(rendered).to include genderize_tag(model, 'helpers.none_registered')
    expect(rendered).to include 'class="table table-striped table-hover table-bordered table-condensed tablesorter tablesorter-blue"'
    expect(rendered).not_to include '<tr id=\'model_'
    expect(rendered).not_to include '<td class="model_id admin-only" style="display: none;">'
    expect(rendered).to include '<thead>'
    expect(rendered).to include '<tbody>'
  end
end

describe 'companies/_form', type: :view do
  it 'renders partials' do
    model = class_name.new
    assign :model, model

    render

    expect(view).to render_template(partial: 'shared/form_errors', locals: { model: model })
    expect(view).to render_template(partial: 'shared/form_commons', locals: { model: model })
    expect(view).to render_template(partial: 'shared/error_alert', locals: { id: 'donation' })
    # expect(view).to render_template(partial: "contacts/contact", locals: {ff: ff, index: index})
    expect(view).to render_template(partial: 'shared/tab_commons', locals: { tab_type: 'contact', number_of_tabs: 3 })
    expect(view).to render_template(partial: 'shared/tab_commons', locals: { tab_type: 'main', number_of_tabs: 3 })
    # expect(view).to render_template(partial: "shared/form_buttons", locals: {model: @model, f: f})
  end

  it 'displays a no-donation message if it s the case' do
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
