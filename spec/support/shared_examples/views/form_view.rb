shared_examples 'an form view' do
  it 'renders basic partials' do
    model = class_name.new
    assign :model, model

    render

    # Partials
    expect(view).to render_template(partial: 'shared/form_errors', locals: { model: model })
    expect(view).to render_template(partial: 'shared/form_commons', locals: { model: model })
    # expect(view).to render_template(partial: "shared/form_buttons", locals: {model: @model, f: f})
  end
end
