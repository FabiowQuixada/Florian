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
  has_one :system_setting, dependent: :destroy


  # Validations
  validates :name, :role, :signature, presence: true
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
    system_setting.pse_title = SETTINGS_PSE_TITLE
    system_setting.pse_body = SETTINGS_PSE_BODY
    system_setting.re_title = SETTINGS_RE_TITLE
    system_setting.re_body = SETTINGS_RE_BODY

    system_setting.valid?
  end

  def default_values
    self.bcc ||= email
    self.signature ||= name
  end
end
