class CompanyDonation < ActiveRecord::Base

  # Configuration
  include GenderHelper


  # Relationships
  belongs_to :user
  belongs_to :company


  # Methods
    def gender
    'f'
  end
end
