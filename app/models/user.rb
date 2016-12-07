class User < ActiveRecord::Base

  audited
  include ModelHelper
  after_initialize :default_values

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable, :recoverable, :rememberable
  devise :database_authenticatable, :registerable, :trackable, :validatable


  # Relationships
  belongs_to :role


  # Validations
  validates :name, :role, :signature, presence: true
  validates :name, :email, uniqueness: true
  validates :locale, presence: true


  # Methods
  def admin?
    return false if role.nil?
    role.name == ADMIN_ROLE
  end

  def guest?
    return false if role.nil?
    role.name == GUEST_ROLE
  end

  def to_s
    name
  end

  def active_for_authentication?
    super && active?
  end

  def active=(value)
    raise I18n.t('errors.user.cannot_deactivate_admin') if admin?
    write_attribute(:active, value)
  end

  def full_signature
    "\n\n--\n\n#{signature}"
  end

  private ##########################################################################################################

  def default_values
    self.bcc ||= email
    self.signature ||= name
  end
end
