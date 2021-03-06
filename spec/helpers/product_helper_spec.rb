require 'rails_helper'

describe ProductHelper do
  describe '#product_classes' do
    let(:common_week) { build :product_and_service_week, number: 3 }
    let(:totals_week) { build :product_and_service_week, :totals }
    let(:final_week) { build :product_and_service_week, :final }

    it { expect(helper.product_classes(common_week, 1)).to eq 'form-control product_input numbers_only product_row_1 product_week_2 input-sm week_2' }
    it { expect(helper.product_classes(common_week, 2)).to eq 'form-control product_input numbers_only product_row_2 product_week_2 input-sm week_2' }
    it { expect(helper.product_classes(totals_week, 3)).to eq 'form-control product_input numbers_only product_row_3 product_week_5 input-sm week_5 extra_tab temp_field' }
    it { expect(helper.product_classes(totals_week, 4)).to eq 'form-control product_input numbers_only product_row_4 product_week_5 input-sm week_5 extra_tab temp_field' }
    it { expect(helper.product_classes(final_week, 5)).to  eq 'form-control product_input numbers_only product_row_5 product_week_6 input-sm week_6 extra_tab temp_field' }
    it { expect(helper.product_classes(final_week, 6)).to  eq 'form-control product_input numbers_only product_row_6 product_week_6 input-sm week_6 extra_tab temp_field' }
  end
end
