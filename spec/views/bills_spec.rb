require 'rails_helper'

class_name = Bill

describe 'bills/index', type: :view do
  it 'renders index page when list is not empty' do
    model = class_name.new
    create :bill
    assign :model, model
    assign :list, class_name.all
    assign :listOfLists, [] # TODO

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
    assign :listOfLists, [] # TODO

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

describe 'bills/_form', type: :view do
  it 'displays the bills location' do
    model = class_name.new
    assign :model, model

    render

    # Partials
    expect(view).to render_template(partial: 'shared/form_errors', locals: { model: model })
    expect(view).to render_template(partial: 'shared/form_commons', locals: { model: model })
  end
end
