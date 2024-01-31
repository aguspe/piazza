class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maximum: 50 }
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  before_validation :strip_name_and_email

  private

  def strip_name_and_email
    self.name = self.name&.strip
    self.email = self.email&.strip
  end
end
