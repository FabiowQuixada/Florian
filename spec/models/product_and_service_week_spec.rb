require 'rails_helper'

describe ProductAndServiceWeek, type: :model do
  week_number = 3

  it { is_expected.to validate_presence_of :number }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }

  it { is_expected.to accept_nested_attributes_for :service_data }
  it { is_expected.to accept_nested_attributes_for :product_data }

  # Relationships
  it { is_expected.to belong_to :product_and_service_datum }

  describe 'period' do
    it 'has a valid period' do
      week = described_class.create(number: week_number, start_date: Date.new(2001, 2, 3), end_date: Date.new(2001, 2, 2))
      expect(week.errors.full_messages).to include I18n.t('errors.product_and_service_datum.invalid_period', week_number: week_number)
    end

    it 'has a start date' do
      week = described_class.new(number: week_number)
      week.start_date = nil
      week.save

      expect(week.errors.full_messages).to include I18n.t('errors.product_and_service_datum.period_is_mandatory', week_number: week_number)
    end

    it 'has an end date' do
      week = described_class.new(number: week_number)
      week.end_date = nil
      week.save
      expect(week.errors.full_messages).to include I18n.t('errors.product_and_service_datum.period_is_mandatory', week_number: week_number)
    end

    it 'has a valid period' do
      week = build :product_and_service_week
      expect(week.start_date <= week.end_date).to be true
    end
  end

  describe 'error messages' do
    it 'displays a general product data message' do
      week = build(:product_and_service_week, number: week_number)
      week.product_data.mesh = nil
      week.save
      expect(week.errors.full_messages).to include I18n.t('errors.product_and_service_datum.all_products_are_mandatory', week_number: week_number)
    end

    it 'displays a general attendance data message' do
      week = build(:product_and_service_week, number: week_number)
      week.service_data[0].mesh = nil
      week.save
      expect(week.errors.full_messages).to include I18n.t('errors.product_and_service_datum.all_attendances_are_mandatory', week_number: week_number)
    end

    it 'displays a general return data message' do
      week = build(:product_and_service_week, number: week_number)
      week.service_data[1].mesh = nil
      week.save
      expect(week.errors.full_messages).to include I18n.t('errors.product_and_service_datum.all_returns_are_mandatory', week_number: week_number)
    end

    it 'does not display product individual error messages' do
      week = described_class.create
      ProductData.products.each do |product|
        expect(week.errors.full_messages).not_to include I18n.t('errors.messages.blank', attribute: product)
      end
    end

    it 'does not display service individual error messages' do
      week = described_class.create
      ServiceData.services.each do |service|
        expect(week.errors.full_messages).not_to include I18n.t('errors.messages.blank', attribute: service)
      end
    end

    it 'does not display service individual error messages' do
      week = described_class.create
      ServiceData.services.each do |service|
        expect(week.errors.full_messages).not_to include I18n.t('errors.messages.blank', attribute: service)
      end
    end
  end

  describe 'item quantities' do
    it 'returns the correct number of services' do
      week = build :product_and_service_week
      week.service_data[0].psychology = 4
      week.service_data[0].mesh = 3

      expect(week.service_qty).to eq 7
    end

    it 'returns the correct number of products' do
      week = build :product_and_service_week
      week.product_data.cervical_collar = 4
      week.product_data.mesh = 3

      expect(week.product_qty).to eq 7
    end
  end

  # Methods #################################################################################

  describe '#title' do
    it { expect(build(:product_and_service_week, number: 3).title).to eq "#{I18n.t('activerecord.models.product_and_service_week.one')} 3" }
  end

  describe '#common?' do
    it { expect(build(:product_and_service_week, number: 0).common?).to be false }
    it { expect(build(:product_and_service_week, number: 1).common?).to be true }
    it { expect(build(:product_and_service_week, number: 5).common?).to be true }
    it { expect(build(:product_and_service_week, number: 6).common?).to be false }
    it { expect(build(:product_and_service_week, number: 7).common?).to be false }
  end

  describe '#totals?' do
    it { expect(build(:product_and_service_week, number: 0).totals?).to be false }
    it { expect(build(:product_and_service_week, number: 1).totals?).to be false }
    it { expect(build(:product_and_service_week, number: 5).totals?).to be false }
    it { expect(build(:product_and_service_week, number: 6).totals?).to be true }
    it { expect(build(:product_and_service_week, number: 7).totals?).to be false }
  end

  describe '#final?' do
    it { expect(build(:product_and_service_week, number: 0).final?).to be false }
    it { expect(build(:product_and_service_week, number: 1).final?).to be false }
    it { expect(build(:product_and_service_week, number: 5).final?).to be false }
    it { expect(build(:product_and_service_week, number: 6).final?).to be false }
    it { expect(build(:product_and_service_week, number: 7).final?).to be true }
  end
end
