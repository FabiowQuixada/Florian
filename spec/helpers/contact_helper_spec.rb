require 'rails_helper'

describe ContactHelper do
  let(:model) { build :contact, id: 4 }

  describe '#contact_hidden_tag' do
    it { expect(helper.contact_hidden_tag(model, 'name').html_safe).to eq "<input value=\"#{model.name}\" type=\"hidden\" name=\"maintainer[contacts_attributes][4][name]\" id=\"maintainer_contacts_attributes_4_name\" />" }
    it do
      expect(helper.contact_hidden_tag(model, 'telephone')).to eq '<input value="" type="hidden" name="maintainer[contacts_attributes][4][telephone]" id="maintainer_contacts_attributes_4_telephone" />'
    end
  end
end
