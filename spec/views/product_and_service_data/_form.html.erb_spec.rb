require 'rails_helper'

class_name = ProductAndServiceDatum

describe 'product_and_service_data/_form', type: :view do
  it 'renders all the services and products (Statusless)' do
    model = class_name.new
    assign :model, model

    render

    # Partials
    expect_to_render_partials(model)

    # P&S data
    expect(rendered).to include I18n.localize(model.competence, format: :competence_i)
    expect(rendered).not_to include 'Status'
    expect(rendered).not_to include 'De ' + Date.today.to_s + ' a ' + Date.today.to_s

    # Tabs
    expect_to_render_week_tabs
    expect(rendered).to include 'Total'
    expect(rendered).not_to include 'Dados finais'

    # Buttons
    expect(rendered).not_to include 'Salvar e enviar'
    expect(rendered).not_to include 'Enviar para análise'
    # expect(rendered).not_to include 'Copiar de "Total"'
    # expect(rendered).not_to include 'Enviar'
  end

  it 'renders all the services and products (Created)' do
    model = create(:product_and_service_datum, :created)
    assign :model, model

    render

    # Partials
    expect_to_render_partials(model)

    # P&S data
    expect(rendered).to include I18n.localize(model.competence, format: :competence).capitalize
    expect(rendered).to include 'Status'
    expect(rendered).not_to include 'De ' + Date.today.to_s + ' a ' + Date.today.to_s

    # Tabs
    expect_to_render_week_tabs
    expect(rendered).to include 'Total'
    expect(rendered).not_to include 'Dados finais'

    # Buttons
    expect(rendered).to include 'Salvar e enviar'
    expect(rendered).to include 'Enviar para análise'
    # expect(rendered).not_to include 'Copiar de "Total"'
    # expect(rendered).not_to include '>Enviar'
  end

  it 'renders all the services and products (On analysis)' do
    model = create(:product_and_service_datum, :on_analysis)
    assign :model, model

    render

    # Partials
    expect_to_render_partials(model)

    # P&S data
    expect(rendered).to include I18n.localize(model.competence, format: :competence).capitalize
    expect(rendered).to include 'Status'
    expect(rendered).to include 'De ' + Date.today.to_s + ' a ' + Date.today.to_s

    # Tabs
    expect_to_render_week_tabs
    expect(rendered).to include 'Total'
    expect(rendered).to include 'Dados finais'

    # Buttons
    expect(rendered).not_to include 'Salvar e enviar'
    expect(rendered).not_to include 'Enviar para análise'
    # expect(rendered).to include 'Copiar de "Total"'
    # expect(rendered).not_to include '>Enviar'
  end

  it 'renders all the services and products (Finalized)' do
    model = create(:product_and_service_datum, :finalized)
    assign :model, model

    render

    # Partials
    expect_to_render_partials(model)

    # P&S data
    expect(rendered).to include I18n.localize(model.competence, format: :competence).capitalize
    expect(rendered).to include 'Status'
    expect(rendered).to include 'De ' + Date.today.to_s + ' a ' + Date.today.to_s

    # Tabs
    expect_to_render_week_tabs
    expect(rendered).to include 'Total'
    expect(rendered).to include 'Dados finais'

    # Buttons
    expect(rendered).not_to include 'Salvar e enviar'
    expect(rendered).not_to include 'Enviar para análise'
    # expect(rendered).not_to include 'Copiar de "Total"'
    # expect(rendered).not_to include '>Enviar'
  end

  def expect_to_render_partials(model)
    expect(view).to render_template(partial: 'shared/form_errors', locals: { model: model })
    expect(view).to render_template(partial: 'shared/form_commons', locals: { model: model })
    expect(view).to render_template(partial: 'shared/tab_commons', locals: { tab_type: 'prod_serv_data', number_of_tabs: 7 })
    expect(view).to render_template(partial: 'product_data/_form', count: 8)
    expect(view).to render_template(partial: 'service_data/_form', count: 8)
  end

  def expect_to_render_week_tabs
    expect(rendered).not_to include 'Semana -1'
    expect(rendered).not_to include 'Semana 0'
    (1..5).each do |i|
      expect(rendered).to include 'Semana ' + i.to_s
    end
    expect(rendered).not_to include 'Semana 6'
  end
end
