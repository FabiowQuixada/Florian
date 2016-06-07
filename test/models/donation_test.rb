require 'test_helper'

class DonationTest < ActiveSupport::TestCase

  test 'should save donation only with remark' do
    donation = Donation.new

    donation.company = Company.first
    donation.remark = 'observacao'
    assert donation.save
  end

  test 'should save donation only with value' do
    donation = Donation.new

    donation.company = Company.first
    donation.value = 10.00
    assert donation.save
  end

  test 'should not save donation only with date' do
    donation = Donation.new
    assert_not donation.save
  end

end
