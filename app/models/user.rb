class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maximum: 50 }, confirmation: true
  validates :password_confirmation, presence: true
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :app_sessions, dependent: :destroy
  before_validation :strip_name_and_email

  def self.create_app_session(email:, password:)
    return nil unless (user = User.find_by(email: email.downcase))

    user.app_sessions.create if user.authenticate(password)
  end

  private

  def strip_name_and_email
    self.name = self.name&.strip
    self.email = self.email&.strip
  end
end
