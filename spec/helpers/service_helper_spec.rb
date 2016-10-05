require 'rails_helper'

describe ServiceHelper do
  describe '#service_field_tag' do
    let(:common_week) { build :product_and_service_week }
    let(:helper_week) { build :product_and_service_week, :helper }

    it { expect(helper.service_field_tag(common_week, 'mesh', 0, 4)).to eq '<input type="text" name="product_and_service_datum[product_and_service_weeks_attributes][2][service_data_attributes][0][mesh]" id="product_and_service_datum_product_and_service_weeks_attributes_2_service_data_attributes_0_mesh" value="0" class="attendance attendance_week_2 service_checkup form-control mesh week_2 numbers_only service_input input-sm service_row_4_col_0" />' }
    it { expect(helper.service_field_tag(common_week, 'psychology', 0, 5)).to eq '<input type="text" name="product_and_service_datum[product_and_service_weeks_attributes][2][service_data_attributes][0][psychology]" id="product_and_service_datum_product_and_service_weeks_attributes_2_service_data_attributes_0_psychology" value="0" class="attendance attendance_week_2 service_checkup form-control psychology week_2 numbers_only service_input input-sm service_row_5_col_0" />' }
    it { expect(helper.service_field_tag(common_week, 'occupational_therapy', 1, 2)).to eq '<input type="text" name="product_and_service_datum[product_and_service_weeks_attributes][2][service_data_attributes][1][occupational_therapy]" id="product_and_service_datum_product_and_service_weeks_attributes_2_service_data_attributes_1_occupational_therapy" value="0" class="return return_week_2 service_return form-control occupational_therapy week_2 numbers_only service_input input-sm service_row_2_col_1" />' }
    it { expect(helper.service_field_tag(common_week, 'gynecology', 1, 6)).to eq '<input type="text" name="product_and_service_datum[product_and_service_weeks_attributes][2][service_data_attributes][1][gynecology]" id="product_and_service_datum_product_and_service_weeks_attributes_2_service_data_attributes_1_gynecology" value="0" class="return return_week_2 service_return form-control gynecology week_2 numbers_only service_input input-sm service_row_6_col_1" />' }

    it { expect(helper.service_field_tag(helper_week, 'mesh', 0, 4)).to eq '<input type="text" name="product_and_service_week[service_data_attributes][0][mesh]" id="product_and_service_week_service_data_attributes_0_mesh" value="0" class="attendance attendance_week_-1 service_checkup form-control mesh week_-1 numbers_only service_input input-sm service_row_4_col_0 extra_tab temp_field" />' }
    it { expect(helper.service_field_tag(helper_week, 'psychology', 0, 5)).to eq '<input type="text" name="product_and_service_week[service_data_attributes][0][psychology]" id="product_and_service_week_service_data_attributes_0_psychology" value="0" class="attendance attendance_week_-1 service_checkup form-control psychology week_-1 numbers_only service_input input-sm service_row_5_col_0 extra_tab temp_field" />' }
    it { expect(helper.service_field_tag(helper_week, 'occupational_therapy', 1, 2)).to eq '<input type="text" name="product_and_service_week[service_data_attributes][1][occupational_therapy]" id="product_and_service_week_service_data_attributes_1_occupational_therapy" value="0" class="return return_week_-1 service_return form-control occupational_therapy week_-1 numbers_only service_input input-sm service_row_2_col_1 extra_tab temp_field" />' }
    it { expect(helper.service_field_tag(helper_week, 'gynecology', 1, 6)).to eq '<input type="text" name="product_and_service_week[service_data_attributes][1][gynecology]" id="product_and_service_week_service_data_attributes_1_gynecology" value="0" class="return return_week_-1 service_return form-control gynecology week_-1 numbers_only service_input input-sm service_row_6_col_1 extra_tab temp_field" />' }
  end

  describe '#service_field_classes' do
    let(:common_week) { build :product_and_service_week }
    let(:totals_week) { build :product_and_service_week, :totals }
    let(:final_week) { build :product_and_service_week, :final }
    let(:helper_week) { build :product_and_service_week, :helper }

    it { expect(helper.service_field_classes(common_week, 'occupational_therapy', 0, 1)). to eq 'attendance attendance_week_2 service_checkup form-control occupational_therapy week_2 numbers_only service_input input-sm service_row_1_col_0' }
    it { expect(helper.service_field_classes(common_week, 'gynecology', 1, 2)). to eq 'return return_week_2 service_return form-control gynecology week_2 numbers_only service_input input-sm service_row_2_col_1' }
    it { expect(helper.service_field_classes(totals_week, 'physiotherapy', 0, 3)). to eq 'attendance attendance_week_5 service_checkup form-control physiotherapy week_5 numbers_only service_input input-sm service_row_3_col_0 extra_tab temp_field' }
    it { expect(helper.service_field_classes(totals_week, 'plastic_surgery', 1, 4)). to eq 'return return_week_5 service_return form-control plastic_surgery week_5 numbers_only service_input input-sm service_row_4_col_1 extra_tab temp_field' }
    it { expect(helper.service_field_classes(final_week, 'physiotherapy', 0, 5)). to eq 'attendance attendance_week_6 service_checkup form-control physiotherapy week_6 numbers_only service_input input-sm service_row_5_col_0 extra_tab temp_field' }
    it { expect(helper.service_field_classes(final_week, 'gynecology', 1, 6)). to eq 'return return_week_6 service_return form-control gynecology week_6 numbers_only service_input input-sm service_row_6_col_1 extra_tab temp_field' }
    it { expect(helper.service_field_classes(helper_week, 'occupational_therapy', 0, 7)). to eq 'attendance attendance_week_-1 service_checkup form-control occupational_therapy week_-1 numbers_only service_input input-sm service_row_7_col_0 extra_tab temp_field' }
    it { expect(helper.service_field_classes(helper_week, 'plastic_surgery', 1, 8)). to eq 'return return_week_-1 service_return form-control plastic_surgery week_-1 numbers_only service_input input-sm service_row_8_col_1 extra_tab temp_field' }
  end

  describe '#serv_class' do
    let(:week_0) { build(:product_and_service_week, number: 1) }
    let(:week_1) { build(:product_and_service_week, number: 2) }

    it { expect(helper.serv_class(0, week_0)). to eq 'attendance attendance_week_0 service_checkup' }
    it { expect(helper.serv_class(1, week_0)). to eq 'return return_week_0 service_return' }
    it { expect(helper.serv_class(0, week_1)). to eq 'attendance attendance_week_1 service_checkup' }
    it { expect(helper.serv_class(1, week_1)). to eq 'return return_week_1 service_return' }
  end
end
