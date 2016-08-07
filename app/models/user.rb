class User < ActiveRecord::Base

  audited
  include ModelHelper
  before_create :build_default_system_setting
  after_initialize :default_values


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable, :recoverable,
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable


  # Relationships
  belongs_to :role
  has_one :system_setting


  # Validations
  validates :name, :email, :role, presence: true
  validates :signature, :bcc, presence: true
  validates :name, :email, uniqueness: true


  # Methods
  def admin?
    return false if role.nil?

    role.name == ADMIN_ROLE
  end

  def guest?
    return false if role.nil?

    role.name == GUEST_ROLE
  end

  def active_for_authentication?
    super && active?
  end

  def active=(value)

    raise I18n.t('errors.user.cannot_deactivate_admin') if admin?

    write_attribute(:active, value)

  end

  def build_default_system_setting
    build_system_setting

    system_setting.pse_recipients_array = SSETTINGS_PSE_RECIPIENTS
    system_setting.pse_day_of_month = SSETTINGS_PSE_DAY
    system_setting.pse_title = SSETTINGS_PSE_TITLE
    system_setting.pse_body = SSETTINGS_PSE_BODY
    system_setting.re_title = SSETTINGS_RE_TITLE
    system_setting.re_body = SSETTINGS_RE_BODY

    system_setting.valid?
  end

  def default_values
    name ||= ''
    self.bcc = email
    self.signature ||= '--\n\n' + name
  end

end
