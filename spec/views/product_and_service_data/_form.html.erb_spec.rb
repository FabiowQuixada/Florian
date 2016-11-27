require 'rails_helper'

describe 'product_and_service_data/_form', type: :view do
  describe 'renders all the services and products (Statusless)' do
    let(:model) { ProductAndServiceDatum.new }

    before :each do
      assign :model, model
      render
    end

    # Partials
    it { expect_to_render_partials }

    # P&S data
    it { expect(rendered).to include I18n.localize(model.competence, format: :competence_i) }
    it { expect(rendered).not_to include I18n.t('activerecord.attributes.product_and_service_datum.status') }
    it { expect(rendered).not_to include "#{I18n.t('helpers.from')} #{I18n.l Date.today} #{I18n.t('helpers.to')} #{I18n.l Date.today}" }

    # Tabs
    it { expect_to_render_week_tabs }
    it { expect(rendered).to include I18n.t('helpers.total') }
    it { expect(rendered).not_to include I18n.t('helpers.final_data') }

    # Buttons
    it { expect(rendered).not_to include I18n.t('helpers.action.email.save_and_send') }
    it { expect(rendered).not_to include I18n.t('helpers.action.send_to_analysis') }
    it { expect(rendered).not_to include I18n.t('helpers.action.product_and_service.update_final_data') }
    it { expect(rendered).not_to include ">#{I18n.t('helpers.action.email.send')}<" }
  end

  describe 'renders all the services and products (Created)' do
    let(:model) { create(:product_and_service_datum, :created) }
    before :each do
      assign :model, model
      render
    end

    # Partials
    it { expect_to_render_partials }

    # P&S data
    it { expect(rendered).to include I18n.localize(model.competence, format: :competence).capitalize }
    it { expect(rendered).to include I18n.t('activerecord.attributes.product_and_service_datum.status') }
    it { expect(rendered).not_to include "#{I18n.t('helpers.from')} #{I18n.l Date.today} #{I18n.t('helpers.to')} #{I18n.l Date.today}" }

    # Tabs
    it { expect_to_render_week_tabs }
    it { expect(rendered).to include I18n.t('helpers.total') }
    it { expect(rendered).not_to include I18n.t('helpers.final_data') }

    # Buttons
    it { expect(rendered).to include I18n.t('helpers.action.email.save_and_send') }
    it { expect(rendered).to include I18n.t('helpers.action.send_to_analysis') }
    it { expect(rendered).not_to include I18n.t('helpers.action.product_and_service.update_final_data') }
    it { expect(rendered).not_to include ">#{I18n.t('helpers.action.email.send')}<" }
  end

  describe 'renders all the services and products (On analysis)' do
    let(:model) { create(:product_and_service_datum, :on_analysis) }
    let(:week) { model.weeks[0] }

    before :each do
      assign :model, model
      render
    end

    # Partials
    it { expect_to_render_partials }

    # P&S data
    it { expect(rendered).to include I18n.localize(model.competence, format: :competence).capitalize }
    it { expect(rendered).to include I18n.t('activerecord.attributes.product_and_service_datum.status') }
    it { expect(rendered).to include "#{I18n.t('helpers.from')} #{week.start_date} #{I18n.t('helpers.to')} #{week.end_date}" }

    # Tabs
    it { expect_to_render_week_tabs }
    it { expect(rendered).to include I18n.t('helpers.total') }
    it { expect(rendered).to include I18n.t('helpers.final_data') }

    # Buttons
    it { expect(rendered).not_to include I18n.t('helpers.action.email.save_and_send') }
    it { expect(rendered).not_to include I18n.t('helpers.action.send_to_analysis') }
    # it { expect(rendered).to include I18n.t('helpers.action.product_and_service.update_final_data') }
    it { expect(rendered).to include ">#{I18n.t('helpers.action.email.send')}<" }
  end

  describe 'renders all the services and products (Finalized)' do
    let(:model) { create(:product_and_service_datum, :finalized) }
    let(:week) { model.weeks[0] }
    
    before :each do
      assign :model, model
      render
    end

    # Partials
    it { expect_to_render_partials }

    # P&S data
    it { expect(rendered).to include I18n.localize(model.competence, format: :competence).capitalize }
    it { expect(rendered).to include I18n.t('activerecord.attributes.product_and_service_datum.status') }
    it { expect(rendered).to include "#{I18n.t('helpers.from')} #{week.start_date} #{I18n.t('helpers.to')} #{week.end_date}" }

    # Tabs
    it { expect_to_render_week_tabs }
    it { expect(rendered).to include I18n.t('helpers.total') }
    it { expect(rendered).to include I18n.t('helpers.final_data') }

    # Buttons
    it { expect(rendered).not_to include I18n.t('helpers.action.email.save_and_send') }
    it { expect(rendered).not_to include I18n.t('helpers.action.send_to_analysis') }
    it { expect(rendered).not_to include I18n.t('helpers.action.product_and_service.update_final_data') }
    it { expect(rendered).not_to include ">#{I18n.t('helpers.action.email.send')}<" }
  end

  def expect_to_render_partials
    expect(view).to render_template(partial: 'shared/tab_commons', locals: { tab_type: 'prod_serv_data', number_of_tabs: 7 })
    expect(view).to render_template(partial: 'product_data/_form', count: 7)
    expect(view).to render_template(partial: 'service_data/_form', count: 7)
  end

  def expect_to_render_week_tabs
    (1..5).each do |i|
      expect(rendered).to include "#{I18n.t('activerecord.models.product_and_service_week.one')} #{i}"
    end

    [-1, 0, 6].each do |i|
      expect(rendered).not_to include "#{I18n.t('activerecord.models.product_and_service_week.one')} #{i}"
    end
  end
end
