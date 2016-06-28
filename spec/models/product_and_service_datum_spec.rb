require 'rails_helper'

describe ProductAndServiceDatum, type: :model do
  it { should define_enum_for(:status) }
  # it { should validate_inclusion_of(:status), in: ProductAndServiceDatum.statuses.keys }

  it { should accept_nested_attributes_for :product_and_service_weeks }

  it { should validate_presence_of(:competence) }
  it { should validate_presence_of(:status) }

  it { should validate_uniqueness_of(:competence) }

  it { expect(build(:product_and_service_datum).can_edit?).to be true }
  it { expect(build(:product_and_service_datum, :created).can_edit?).to be true }
  it { expect(build(:product_and_service_datum, :on_analysis).can_edit?).to be true }
  it { expect(build(:product_and_service_datum, :finalized).can_edit?).to be false }

  # Relationships
  it { should have_many :product_and_service_weeks }
  it { expect(build(:product_and_service_datum).weeks).to have(7).items }
  it { expect(build(:product_and_service_datum).final_week.number).to eq 7 }

  it 'saves its competence as day 1 of the month' do
    datum = described_class.create!(competence: Date.new(2001, 2, 3))
    expect(datum.competence.day).to eq 1
  end

  it 'returns the correct number of services' do
    datum = build :product_and_service_datum
    sum = 0

    datum.weeks.each { |week| sum += week.service_qty if week.number <= 5 }

    expect(datum.service_qty).to eq sum
  end

  it 'returns the correct number of product' do
    datum = build :product_and_service_datum
    sum = 0

    datum.weeks.each { |week| sum += week.product_qty if week.number <= 5 }

    expect(datum.product_qty).to eq sum
  end
end
