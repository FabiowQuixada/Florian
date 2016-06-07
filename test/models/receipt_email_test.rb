require 'test_helper'

class ReceiptEmailTest < ActiveSupport::TestCase

  test 'Competence in body text should be consistent' do
    user = User.first
    competence = Date.today
    email = ReceiptEmail.first
    email.body += I18n.t('tags.competence') + I18n.t('tags.company') + I18n.t('tags.value')

    assert_contains I18n.localize(competence, format: :competence).capitalize, email.processed_body(user, competence)

    competence = Date.today.next_month
    assert_contains I18n.localize(competence, format: :competence).capitalize, email.processed_body(user, competence)
  end

  test 'Competence in receipt text should be consistent' do
    user = User.first
    competence = Date.today
    email = ReceiptEmail.first

    assert_contains I18n.localize(competence, format: :competence).capitalize, email.processed_receipt_text(competence)

    competence = Date.today.next_month
    assert_contains I18n.localize(competence, format: :competence).capitalize, email.processed_receipt_text(competence)
  end

  private

  def assert_contains(expected_substring, string, *_args)
    msg = message(msg) { "Expected #{mu_pp string} to contain #{mu_pp expected_substring}" }
    assert string.include?(expected_substring), msg
    end

end
