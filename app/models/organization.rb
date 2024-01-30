class Organization < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user
end
