module DonationHelper

  def donation_hidden_tag(donation, field)
    tag :input,
        value: donation.send(field).to_s,
        type: 'hidden',
        name: "maintainer[donations_attributes][#{donation.id}][#{field}]",
        id: "maintainer_donations_attributes_#{donation.id}_#{field}"
  end

  def save_and_new_btn(model)
    link_to genderize_full_tag(model, 'helpers.action.update_and_new'), 'javascript:void(0)', id: 'create_and_new_btn', class: 'btn btn-primary resend_btn' if model.new_record?
  end
end
