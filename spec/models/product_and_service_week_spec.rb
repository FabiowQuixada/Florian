require 'rails_helper'

describe ProductAndServiceWeek, type: :model do
  week_number = 3

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

  it 'has a end date' do
    week = described_class.new(number: week_number)
    week.end_date = nil
    week.save
    expect(week.errors.full_messages).to include I18n.t('errors.product_and_service_datum.period_is_mandatory', week_number: week_number)
  end

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

  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }

  # TODO: start before end
  it { should accept_nested_attributes_for :service_data }
  it { should accept_nested_attributes_for :product_data }

  it { should accept_nested_attributes_for :service_data }
  it { should accept_nested_attributes_for :product_data }

  # Relationships
  it { should belong_to :product_and_service_datum }
end
