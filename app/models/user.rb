class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  before_validation :strip_name_and_email

  private

  def strip_name_and_email
    self.name = self.name&.strip
    self.email = self.email&.strip
  end
end
