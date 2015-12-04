class User < ActiveRecord::Base

  audited
  include ModelHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable, :recoverable,
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable


  # Relationships
  belongs_to :role


  # Validations
  validates :name, :email, :role, :presence => true
  validates :signature, :test_recipient, :bcc, :presence => true


  # Methods
  def admin?

    if self.role.nil?
      return false
    end

    self.role.name == "Admin"
  end

  def active_for_authentication?
        # Uncomment the below debug statement to view the properties of the returned self model values.
        # logger.debug self.to_yaml

    super && active?
  end

end
