require 'rails_helper'

describe ProductAndServiceDataHelper do
  let(:common_week) { build :product_and_service_week }
  let(:totals_week) { build :product_and_service_week, :totals }
  let(:final_week) { build :product_and_service_week, :final }
  let(:helper_week) { build :product_and_service_week, :helper }
  let(:finalized_week) { build :product_and_service_week, :finalized_datum }
  let(:on_analysis_week) { build :product_and_service_week, :on_analysis_datum }

  it { expect(helper.send_to_analysis_btn).to eq "<a id=\"update_and_send_btn_5\" class=\"btn btn-primary send_btn\" href=\"javascript:void(0)\">Enviar para análise</a>" }
  it { expect(helper.send_mainteiners_btn).to eq '<a id="update_and_send_btn_6" class="btn btn-primary send_btn" href="javascript:void(0)">Enviar</a>' }


  describe '#fields_readonly?' do
    it { expect(helper.fields_readonly?(totals_week)).to be true }
    it { expect(helper.fields_readonly?(finalized_week)).to be true }
    it { expect(helper.fields_readonly?(on_analysis_week)).to be true }
    it { expect(helper.fields_readonly?(final_week)).to be false }
    it { expect(helper.fields_readonly?(common_week)).to be false }
  end

  describe '#week_range_readonly?' do
    it { expect(helper.week_range_readonly?(common_week)).to be false }
    it { expect(helper.fields_readonly?(finalized_week)).to be true }
    it { expect(helper.fields_readonly?(on_analysis_week)).to be true }
  end

  describe '#save_and_send_btn' do
    it { expect(helper.save_and_send_btn(common_week)).to eq(link_to(t('helpers.action.email.save_and_send'), 'javascript:void(0)', id: "update_and_send_btn_#{common_week.index}", class: 'btn btn-primary')) }
  end
end
