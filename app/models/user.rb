class User < ActiveRecord::Base

  audited
  include GenderHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable, :recoverable,
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable


  # Relationships
  belongs_to :role


  # Validations
  validates :name, :email, :role, :presence => true


  # Methods
  def admin?

    if self.role.nil?
      return false
    end

    self.role.name == "Admin"
  end

end
