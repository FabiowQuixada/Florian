module ContactHelper

  def contact_hidden_tag(contact, field)
    tag :input,
        value: contact.send(field).to_s,
        type: 'hidden',
        name: "maintainer[contacts_attributes][#{contact.id}][#{field}]",
        id: "maintainer_contacts_attributes_#{contact.id}_#{field}"
  end
end
