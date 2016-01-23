class User < ActiveRecord::Base

  audited
  include ModelHelper
  before_create :build_default_system_setting


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

  def build_default_system_setting
  # build default profile instance. Will use default params.
  # The foreign key to the owning User model is set automatically
  build_system_setting

  system_setting.pse_recipients_array = '(Preencha)'
  system_setting.pse_day_of_month = '(Preencha)'
  system_setting.pse_title = '(Preencha)'
  system_setting.pse_body = '(Preencha)'
  system_setting.re_title = '(Preencha)'
  system_setting.re_body = '(Preencha)'

  system_setting.valid?
end

end
