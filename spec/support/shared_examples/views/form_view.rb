shared_examples 'an form view' do
  it 'renders basic partials' do
    model = class_name.new
    assign :model, model

    render

    # Partials
    expect(view).to render_template('shared/_form_errors')
    expect(view).to render_template('shared/_form_commons')
  end
end
