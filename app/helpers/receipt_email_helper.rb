module ReceiptEmailHelper

  def resend_btn
    link_to image_tag('send_email.png', title: t('description.email.resend')), 'javascript:void(0)', class: 'resend_btn'
  end

  def send_test_btn
    link_to image_tag('test_email.png', title: t('description.email.send_test') + " '" + current_user.email + "'"), 'javascript:void(0)', remote: true, class: 'send_test_btn'
  end
end
