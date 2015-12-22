class User < ActiveRecord::Base

  audited
  include ModelHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable, :recoverable,
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable


  # Relationships
  belongs_to :role
  has_one :system_setting


  # Validations
  validates :name, :email, :role, :presence => true
  validates :signature, :bcc, :presence => true


  # Methods
  def admin?

    if self.role.nil?
      return false
    end

    self.role.name == "Admin"
  end

  def active_for_authentication?
    super && active?
  end

  def active=(value)

    raise I18n.t('errors.user.cannot_deactivate_admin') if admin?

    write_attribute(:active, value)

  end

end
