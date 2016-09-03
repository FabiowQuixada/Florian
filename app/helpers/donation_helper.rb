module DonationHelper

  def donation_hidden_tag(donation, field)
    # TODO: Safe?
    ('<input value="' + donation.send(field).to_s + "\" type=\"hidden\" name=\"company[donations_attributes][#{donation.id}][#{field}]\" id=\"company_donations_attributes_#{donation.id}_#{field}\">").html_safe
  end
end
