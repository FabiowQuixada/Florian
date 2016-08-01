module MailerHelper
  def body_text(mail)
    mail.body.parts.find { |p| p.content_type.match /plain/ }.body.raw_source
end

  def body_html(mail)
    mail.body.parts.find { |p| p.content_type.match /html/ }.body.raw_source
  end
end

RSpec.configure do |config|
  config.include MailerHelper, type: :mailer
end
