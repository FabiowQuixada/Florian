module ReceiptEmailHelper

  def resend_btn
    link_to image_tag('send_email.png', title: t('description.email.resend'), alt: t('description.email.resend')), 'javascript:void(0)', class: 'resend_btn'
  end

  def send_test_btn
    link_to image_tag('test_email.png', title: "#{t('description.email.send_test')} '#{current_user.email}'"), 'javascript:void(0)', remote: true, class: 'send_test_btn'
  end

  def recent_emails_btn
    link_to t('helpers.receipt_email.recent'), 'javascript:void(0)', id: 'recent_emails_btn', class: 'btn btn-primary'
  end

  def resend_form_btn(model)
    link_to t('helpers.action.email.resend'), 'javascript:void(0)', class: 'btn btn-primary resend_btn' unless model.new_record?
  end

  def send_test_form_btn(model)
    link_to t('helpers.action.email.send_test'), 'javascript:void(0)', class: 'btn btn-primary send_test_btn' unless model.new_record?
  end
end
