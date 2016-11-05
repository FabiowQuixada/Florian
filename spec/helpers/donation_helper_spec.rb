require 'rails_helper'

describe DonationHelper do
  let(:model) { build :donation, id: 4 }

  describe '#donation_hidden_tag' do
    it { expect(helper.donation_hidden_tag(model, 'donation_date')).to eq tag :input, value: model.donation_date, type: 'hidden', name: "maintainer[donations_attributes][#{model.id}][donation_date]", id: "maintainer_donations_attributes_#{model.id}_donation_date" }
    it { expect(helper.donation_hidden_tag(model, 'remark')).to eq tag :input, value: model.remark, type: 'hidden', name: "maintainer[donations_attributes][#{model.id}][remark]", id: "maintainer_donations_attributes_#{model.id}_remark" }
  end

  describe '#save_and_new_btn' do
    it { expect(helper.save_and_new_btn(model)).to eq '<a id="create_and_new_btn" class="btn btn-primary resend_btn" href="javascript:void(0)">Salvar e cadastrar nova</a>' }
  end
end
