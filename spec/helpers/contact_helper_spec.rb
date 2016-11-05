module ContactHelper

  def contact_hidden_tag(contact, field)
    tag :input,
        value: contact.send(field).to_s,
        type: 'hidden',
        name: "maintainer[contacts_attributes][#{contact.id}][#{field}]",
        id: "maintainer_contacts_attributes_#{contact.id}_#{field}"
  end
end

require 'rails_helper'

describe ContactHelper do
  let(:model) { build :contact, id: 4 }

  describe '#contact_hidden_tag' do
    it { expect(helper.contact_hidden_tag(model, 'name')).to eq '<input value="Contact 5" type="hidden" name="maintainer[contacts_attributes][4][name]" id="maintainer_contacts_attributes_4_name" />' }
    it do
      expect(helper.contact_hidden_tag(model, 'telephone')).to eq '<input value="" type="hidden" name="maintainer[contacts_attributes][4][telephone]" id="maintainer_contacts_attributes_4_telephone" />'
    end
  end
end
