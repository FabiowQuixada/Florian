require "rails_helper"

describe Donation, :type => :model do

  it "should not save if there is no value and no observation" do
	before_count = Donation.count
	Donation.create(donation_date: Date.new(2001,2,3))
	expect(Donation.count).to eq(before_count)
  end

  it { should validate_presence_of(:donation_date) }
  it { should validate_presence_of(:company) }

  # Relationships
  it { should belong_to :company }

end