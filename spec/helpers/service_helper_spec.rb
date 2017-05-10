require 'rails_helper'

describe ServiceHelper do
  describe '#service_field_tag' do
    let(:common_week) { build :product_and_service_week, number: 3 }

    it { expect(helper.service_field_tag(common_week, 'mesh', 0, 4)).to include "id=\"w#{common_week.index}_service_mesh_c0" }
    it { expect(helper.service_field_tag(common_week, 'psychology', 1, 5)).to include "id=\"w#{common_week.index}_service_psychology_c1" }
  end
end
