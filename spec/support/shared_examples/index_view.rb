shared_examples 'an index view' do
  it 'when list is not empty' do
    model = class_name.new
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

  it 'when list is empty' do
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
