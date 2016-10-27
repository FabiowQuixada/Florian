require 'rails_helper'

describe ProductAndServiceDatum, type: :model do
  it { is_expected.to define_enum_for(:status) }

  it { is_expected.to accept_nested_attributes_for :product_and_service_weeks }

  it { is_expected.to validate_presence_of(:competence) }
  it { is_expected.to validate_presence_of(:status) }

  it { is_expected.to validate_uniqueness_of(:competence) }

  it { expect(build(:product_and_service_datum).can_edit?).to be true }
  it { expect(build(:product_and_service_datum, :created).can_edit?).to be true }
  it { expect(build(:product_and_service_datum, :on_analysis).can_edit?).to be true }
  it { expect(build(:product_and_service_datum, :finalized).can_edit?).to be false }

  # Relationships
  it { is_expected.to have_many :product_and_service_weeks }
  it { expect(build(:product_and_service_datum).weeks).to have(7).items }
  it { expect(build(:product_and_service_datum).final_week.number).to eq 7 }

  it { expect(described_class.create!(competence: Date.new(2001, 2, 3)).competence.day).to eq 1 }

  it 'returns the correct number of services' do
    datum = build :product_and_service_datum
    sum = 0

    datum.weeks.each { |week| sum += week.service_qty if week.common? }

    expect(datum.service_qty).to eq sum
  end

  it 'returns the correct number of product' do
    datum = build :product_and_service_datum
    sum = 0

    datum.weeks.each { |week| sum += week.product_qty if week.common? }

    expect(datum.product_qty).to eq sum
  end

  # Methods #################################################################################
  describe '#can_edit?' do
    it { expect((build :product_and_service_datum, :created).can_edit?).to be true }
    it { expect((build :product_and_service_datum, :on_analysis).can_edit?).to be true }
    it { expect((build :product_and_service_datum, :finalized).can_edit?).to be false }
  end

  describe '#status_desc' do
    it { expect((build :product_and_service_datum, :created).status_desc).to eq I18n.t('enums.product_and_service_datum.status.created') }
    it { expect((build :product_and_service_datum, :on_analysis).status_desc).to eq I18n.t('enums.product_and_service_datum.status.on_analysis') }
    it { expect((build :product_and_service_datum, :finalized).status_desc).to eq I18n.t('enums.product_and_service_datum.status.finalized') }
  end

  describe '#final_week' do
    let(:prod_serv_datum) { build :product_and_service_datum }
    it { expect(prod_serv_datum.final_week).to be prod_serv_datum.weeks[6] }
  end

  describe '#validate_model' do
    let(:datum) { build :product_and_service_datum }
    let(:extra_week_datum) do
      datum = build :product_and_service_datum
      datum.weeks.new
      datum
    end

    let(:missing_week_datum) do
      datum = build :product_and_service_datum
      datum.weeks.delete datum.weeks.last
      datum
    end

    let(:no_week_datum) do
      datum = build :product_and_service_datum
      datum.weeks.clear
      datum
    end

    it { expect(datum.send(:validate_model)).to be_nil }
    it { expect(extra_week_datum.send(:validate_model)).to eq [I18n.t('errors.product_and_service_datum.weeks_qty', weeks: 8)] }
    it { expect(missing_week_datum.send(:validate_model)).to eq [I18n.t('errors.product_and_service_datum.weeks_qty', weeks: 6)] }
    it { expect(no_week_datum.send(:validate_model)).to eq [I18n.t('errors.product_and_service_datum.weeks_qty', weeks: 0)] }
  end
end
