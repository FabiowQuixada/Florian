module DonationHelper

  def donation_hidden_tag(donation, field)
    # TODO: Safe?
    ('<input value="' + donation.send(field).to_s + "\" type=\"hidden\" name=\"company[donations_attributes][#{donation.id}][#{field}]\" id=\"company_donations_attributes_#{donation.id}_#{field}\">").html_safe
  end

  def save_and_new_btn(model, form)
    link_to genderize_full_tag(model, 'helpers.action.update_and_new'), 'javascript:void(0)', id: 'create_and_new_btn', class: 'btn btn-primary resend_btn' if form.object.new_record?
  end
end
