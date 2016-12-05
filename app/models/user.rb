class User < ActiveRecord::Base

  audited
  include ModelHelper
  before_create :build_default_system_setting
  after_initialize :default_values

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable, :recoverable, :rememberable
  devise :database_authenticatable, :registerable, :trackable, :validatable


  # Relationships
  belongs_to :role
  has_one :system_setting, dependent: :destroy


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

  def build_default_system_setting
    build_system_setting

    system_setting.pse_recipients_array = SAMPLE_RECIPIENTS
    system_setting.pse_title = I18n.t('defaults.report.product_and_service.email_title')
    system_setting.pse_body = I18n.t('defaults.report.product_and_service.monthly_email_body')
    system_setting.re_title = I18n.t('defaults.report.receipt.email_title')
    system_setting.re_body = I18n.t('defaults.report.receipt.email_body')

    system_setting.valid?
  end

  def default_values
    self.bcc ||= email
    self.signature ||= name
  end
end
