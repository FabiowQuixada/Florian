require 'rails_helper'

# class_name =

describe 'product_and_service_data/_form', type: :view do
  describe 'renders all the services and products (Statusless)' do
    let(:model) { ProductAndServiceDatum.new }

    before :each do
      assign :model, model
      render
    end

    # Partials
    it { expect_to_render_partials(model) }

    # P&S data
    it { expect(rendered).to include I18n.localize(model.competence, format: :competence_i) }
    it { expect(rendered).not_to include 'Status' }
    it { expect(rendered).not_to include 'De ' + Date.today.to_s + ' a ' + Date.today.to_s }

    # # Tabs
    it { expect_to_render_week_tabs }
    it { expect(rendered).to include 'Total' }
    it { expect(rendered).not_to include 'Dados finais' }

    # # Buttons
    it { expect(rendered).not_to include 'Salvar e enviar' }
    it { expect(rendered).not_to include 'Enviar para análise' }
    it { expect(rendered).not_to include 'Copiar de &quot;Total&quot;' }
    it { expect(rendered).not_to include '>Enviar<' }
  end

  describe 'renders all the services and products (Created)' do
    let(:model) { create(:product_and_service_datum, :created) }
    before :each do
      assign :model, model

      render
    end

    # Partials
    it { expect_to_render_partials(model) }

    # P&S data
    it { expect(rendered).to include I18n.localize(model.competence, format: :competence).capitalize }
    it { expect(rendered).to include 'Status' }
    it { expect(rendered).not_to include 'De ' + Date.today.to_s + ' a ' + Date.today.to_s }

    # Tabs
    it { expect_to_render_week_tabs }
    it { expect(rendered).to include 'Total' }
    it { expect(rendered).not_to include 'Dados finais' }

    # Buttons
    it { expect(rendered).to include 'Salvar e enviar' }
    it { expect(rendered).to include 'Enviar para análise' }
    it { expect(rendered).not_to include 'Copiar de &quot;Total&quot;' }
    it { expect(rendered).not_to include '>Enviar<' }
  end

  describe 'renders all the services and products (On analysis)' do
    let(:model) { create(:product_and_service_datum, :on_analysis) }

    before :each do
      assign :model, model

      render
    end

    # Partials
    it { expect_to_render_partials(model) }

    # P&S data
    it { expect(rendered).to include I18n.localize(model.competence, format: :competence).capitalize }
    it { expect(rendered).to include 'Status' }
    it { expect(rendered).to include 'De ' + Date.today.to_s + ' a ' + Date.today.to_s }

    # Tabs
    it { expect_to_render_week_tabs }
    it { expect(rendered).to include 'Total' }
    it { expect(rendered).to include 'Dados finais' }

    # Buttons
    it { expect(rendered).not_to include 'Salvar e enviar' }
    it { expect(rendered).not_to include 'Enviar para análise' }
    it { expect(rendered).to include 'Copiar de &quot;Total&quot;' }
    it { expect(rendered).to include '>Enviar<' }
  end

  describe 'renders all the services and products (Finalized)' do
    let(:model) { create(:product_and_service_datum, :finalized) }
    before :each do
      assign :model, model

      render
    end

    # Partials
    it { expect_to_render_partials(model) }

    # P&S data
    it { expect(rendered).to include I18n.localize(model.competence, format: :competence).capitalize }
    it { expect(rendered).to include 'Status' }
    it { expect(rendered).to include 'De ' + Date.today.to_s + ' a ' + Date.today.to_s }

    # Tabs
    it { expect_to_render_week_tabs }
    it { expect(rendered).to include 'Total' }
    it { expect(rendered).to include 'Dados finais' }

    # Buttons
    it { expect(rendered).not_to include 'Salvar e enviar' }
    it { expect(rendered).not_to include 'Enviar para análise' }
    it { expect(rendered).not_to include 'Copiar de &quot;Total&quot;' }
    it { expect(rendered).not_to include '>Enviar<' }
  end

  # rubocop:disable all
  def expect_to_render_partials(model)
    expect(view).to render_template(partial: 'shared/form_errors', locals: { model: model })
    expect(view).to render_template(partial: 'shared/form_commons', locals: { model: model })
    expect(view).to render_template(partial: 'shared/tab_commons', locals: { tab_type: 'prod_serv_data', number_of_tabs: 7 })
    expect(view).to render_template(partial: 'product_data/_form', count: 7)
    expect(view).to render_template(partial: 'service_data/_form', count: 7)
  end
  # rubocop:enable all

  # rubocop:disable all
  def expect_to_render_week_tabs
    expect(rendered).not_to include 'Semana -1'
    expect(rendered).not_to include 'Semana 0'
    (1..5).each do |i|
      expect(rendered).to include 'Semana ' + i.to_s
    end
    expect(rendered).not_to include 'Semana 6'
  end
  # rubocop:enable all
end
